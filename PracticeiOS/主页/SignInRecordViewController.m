//
//  SignInRecordViewController.m
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/21.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "SignInRecordViewController.h"

@interface SignInRecordViewController ()

@end

@implementation SignInRecordViewController

- (SignInRecordModel *)SignInRecord {
  if (_SignInRecord == nil) {
    _SignInRecord = [[SignInRecordModel alloc] init];
  }
  return _SignInRecord;
}

- (NSMutableArray *)DataArray {
  if (_DataArray == nil) {
    _DataArray = [[NSMutableArray alloc] init];
  }
  return _DataArray;
}
- (UITableView *)SignInRecordTableView {
  if (_SignInRecordTableView == nil) {
    _SignInRecordTableView = [[UITableView alloc]
        initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)
                style:UITableViewStylePlain];
    _SignInRecordTableView.delegate = self;
    _SignInRecordTableView.dataSource = self;
    _SignInRecordTableView.separatorStyle = 0;
    _SignInRecordTableView.rowHeight = 60;
    _SignInRecordTableView.mj_header =
        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          _pageNumber = 1;
          [self.DataArray removeAllObjects];
          [self SignInRecordData];
        }];
    _SignInRecordTableView.mj_footer =
        [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
          _pageNumber++;
          [self SignInRecordData];
        }];
    [self.view addSubview:_SignInRecordTableView];
  }
  return _SignInRecordTableView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self addNavigationHeadBackImage];
  [self addtitleWithString:@"签到记录"];
  [self addBackButton];
  [self SignInRecordData];
  _pageNumber = 1;
}
- (void)back {
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  SignInRecordTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (cell == nil) {
    cell = [[NSBundle mainBundle] loadNibNamed:@"SignInRecordTableViewCell"
                                         owner:nil
                                       options:nil][0];
  }
  [self.SignInRecord mj_setKeyValues:_DataArray[indexPath.row]];
  cell.addressLabel.text = _SignInRecord.location.positionDescn;
  cell.timeLabel.text = _SignInRecord.createTime;
  cell.squreView.layer.cornerRadius = 5;
  cell.squreView.clipsToBounds = YES;
  return cell;
}

#pragma mark 签到记录请求
- (void)SignInRecordData {
  [[HttpTool sharedInstance] postWithUrl:student_signRecord
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID,
        @"pageNumber" : @(_pageNumber)
      }
      sucess:^(id json) {
        if ([json[@"status"] intValue] == 200) {
          [self.DataArray addObjectsFromArray:json[@"data"][@"data"]];
        } else {
          KOMG(json[@"msg"]);
        }
        [self.SignInRecordTableView.mj_header endRefreshing];
        [self.SignInRecordTableView.mj_footer endRefreshing];
        [self.SignInRecordTableView reloadData];
      }
      failur:^(NSError *error) {
        [self.SignInRecordTableView.mj_header endRefreshing];
        [self.SignInRecordTableView.mj_footer endRefreshing];
        KOMG(kHttpError);

      }];
}
@end
