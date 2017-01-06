//
//  MessageViewController.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/14.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessageViewController.h"
#import "MessageRequest.h"
#import "MessageDetailViewController.h"


@interface MessageViewController () <UITableViewDelegate,
                                     UITableViewDataSource> {
  UITableView *_messageTableview;
  int _currentPage;
  NSMutableArray *_dataArray;
  UIView *_footView;
  BOOL _hasNextPage;
  MJRefreshFooter *_footer;
}
@end

@implementation MessageViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [GiFHUD dismiss];//取消加载
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self addNavigationHeadBackImage];
  [self addtitleWithString:@"消息"];
  [self TheDrawer];
    
    //注册监听,监听是否有新消息
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(freshTableview)
     name:@"newMessage"
     object:nil];
    
  _messageTableview = [[UITableView alloc]
      initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 114)
              style:UITableViewStylePlain];
  _messageTableview.delegate = self;
  _messageTableview.dataSource = self;
    _messageTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.view addSubview:_messageTableview];
    
    
    [self loadDataWithType:@"首次"];
    //下拉刷新
    _messageTableview.mj_header =
    [MJRefreshGifHeader headerWithRefreshingBlock:^{
        _currentPage = 1;
        [self loadDataWithType:@"下拉刷新"];
    }];
    //上拉加载更多
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage ++;
        [self loadDataWithType:@"上拉加载"];
    }];
    
    
    //footerView
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    footLabel.text = @"没有更多了";
    footLabel.textAlignment = 1;
    [_footView addSubview:footLabel];
}

-(void)loadDataWithType:(NSString *)typeStr{
    
    
    [GiFHUD show];//加载动画
    
    //第一次加载准备
    if ([typeStr isEqualToString:@"首次"]) {
        _currentPage = 1;
        if (_dataArray == nil) {
            _dataArray = [[NSMutableArray alloc]init];
        }
    }
    [MessageRequest messageListRequestWithPageNumber:FORMATSTRING1(_currentPage) WithToken:UDOBJ(ZToken) WithClient:DEVICEUUID WithCompletionBlack:^(NSDictionary *dic) {
        if ([dic[@"status"]intValue] == 200) {
            //首次和下拉刷新需要清空数组,上拉加载不需要
            if ([typeStr isEqualToString:@"首次"]||[typeStr isEqualToString:@"下拉刷新"]) {
                [_dataArray removeAllObjects];
            }
            NSArray *array = dic[@"data"][@"data"][@"data"];
            for (NSDictionary *dicc in array) {
                [_dataArray addObject:dicc];
            }
            [_messageTableview reloadData];
        }
        else{
            KOMG(dic[@"msg"]);
        }
        //判断是处在哪种状态
        if ([typeStr isEqualToString:@"首次"]) {
            //回调和监听也调用首次加载,如果未读数为0，取消角标和红点
            if ([dic[@"data"][@"rows"]intValue] == 0) {
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
            }
        }
        else if([typeStr isEqualToString:@"下拉刷新"]){
            [_messageTableview.mj_header endRefreshing];
        }
        else{
            [_messageTableview.mj_footer endRefreshing];
        }
        
        //是否存在下一页
        if([dic[@"data"][@"data"][@"hasNextPage"]intValue] == 0){
            _messageTableview.mj_footer = nil;
            _messageTableview.tableFooterView = _footView;
        }
        else{
            _messageTableview.mj_footer = _footer;
            _messageTableview.tableFooterView = nil;
        }
        
        [GiFHUD dismiss];//取消加载
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MessageTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
  if (cell == nil) {
    cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell"
                                          owner:nil
                                        options:nil] objectAtIndex:0];
  }
  NSDictionary *dic = _dataArray[indexPath.row];
  cell.titleLabel.text = dic[@"notice"][@"title"];
  cell.timeLabel.text = dic[@"createTime"];
    if ([dic[@"status"] isEqualToString:@"N"]) {
        cell.redView.layer.cornerRadius = 2.5;
        cell.redView.clipsToBounds = YES;
        cell.redView.hidden = NO;
    }
    else{
        cell.redView.hidden = YES;
    }
  return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArray[indexPath.row];
    MessageDetailViewController *detailVC = [[MessageDetailViewController alloc]init];
    detailVC.url = dic[@"notice"][@"url"];
    detailVC.isRead = dic[@"status"];
    detailVC.freshBlock = ^{
        [self loadDataWithType:@"首次"];
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

//有未读消息
-(void)freshTableview{
    [self loadDataWithType:@"首次"];
}

@end
