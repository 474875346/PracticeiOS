//
//  MonthlyRecordViewController.m
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/30.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "MonthlyRecordViewController.h"

@interface MonthlyRecordViewController ()

@end

@implementation MonthlyRecordViewController

- (UITableView *)MonthlyRecordTableView {
  if (_MonthlyRecordTableView == nil) {
    _MonthlyRecordTableView = [[UITableView alloc]
        initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)
                style:UITableViewStylePlain];
    _MonthlyRecordTableView.delegate = self;
    _MonthlyRecordTableView.dataSource = self;
    _MonthlyRecordTableView.separatorStyle = 0;
    _MonthlyRecordTableView.mj_header =
        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          _pageNum = 1;
          [self.monthlyrecordArray removeAllObjects];
          [self MonthlyRecordData];
        }];
    _MonthlyRecordTableView.mj_footer =
        [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
          _pageNum++;
          [self MonthlyRecordData];
        }];
    [self.view addSubview:_MonthlyRecordTableView];
  }
  return _MonthlyRecordTableView;
}

- (NSMutableArray *)monthlyrecordArray {
  if (_monthlyrecordArray == nil) {
    _monthlyrecordArray = [[NSMutableArray alloc] init];
  }
  return _monthlyrecordArray;
}
- (MonthlyRecordModel *)monthlyrecord {
  if (_monthlyrecord == nil) {
    _monthlyrecord = [[MonthlyRecordModel alloc] init];
  }
  return _monthlyrecord;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self addNavigationHeadBackImage];
  [self addtitleWithString:@"月报记录"];
  [self addBackButton];
  [self.MonthlyRecordTableView.mj_header beginRefreshing];
}
- (void)back {
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return self.monthlyrecordArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MonthlyRecordCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[NSBundle mainBundle] loadNibNamed:@"MonthlyRecordCell"
                                         owner:nil
                                       options:nil][0];
  }
  [self.monthlyrecord mj_setKeyValues:self.monthlyrecordArray[indexPath.row]];
  cell.timeLabel.text = self.monthlyrecord.createTime;
  cell.contentLabel.text = self.monthlyrecord.summary;
  return cell;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.monthlyrecord mj_setKeyValues:self.monthlyrecordArray[indexPath.row]];
  MonthlyReportDetailsViewController *MonthlyReportDetails =
      [MonthlyReportDetailsViewController new];
  MonthlyReportDetails.monthlyrecord = self.monthlyrecord;
  [self presentViewController:MonthlyReportDetails animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.monthlyrecord mj_setKeyValues:self.monthlyrecordArray[indexPath.row]];
  CGSize size =
      [self getAttributeSizeWithText:self.monthlyrecord.summary fontSize:20];
  return size.height + 30;
}

#pragma mark 月报记录请求
- (void)MonthlyRecordData {
  [[HttpTool sharedInstance] postWithUrl:student_reportquery
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID,
        @"pageNumber" : @(_pageNum)
      }
      sucess:^(id json) {
        if ([json[@"status"] intValue] == 200) {
          [self.monthlyrecordArray addObjectsFromArray:json[@"data"][@"data"]];
        } else {
          KOMG(json[@"msg"]);
        }
        [self.MonthlyRecordTableView reloadData];
      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }];
  [self.MonthlyRecordTableView.mj_header endRefreshing];
  [self.MonthlyRecordTableView.mj_footer endRefreshing];
}
- (CGSize)getAttributeSizeWithText:(NSString *)text fontSize:(int)fontSize {
  CGSize size =
      [text boundingRectWithSize:CGSizeMake(ScreenWidth, MAXFLOAT)
                         options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{
                        NSFontAttributeName : [UIFont systemFontOfSize:fontSize]
                      }
                         context:nil]
          .size;
  return size;
}

@end
