//
//  MonthlyReportView.m
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/30.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "MonthlyReportView.h"

@implementation MonthlyReportView

- (id)initWithFrame:(CGRect)frame
         TitleArray:(NSString *)title
       ContentArray:(NSString *)content {
  self = [super initWithFrame:frame];
  if (self) {
    UILabel *MonthlyReportContentTitle =
        [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
    MonthlyReportContentTitle.text = title;
    [self addSubview:MonthlyReportContentTitle];
    UILabel *MonthlyReportContent = [[UILabel alloc]
        initWithFrame:CGRectMake(10, YH(MonthlyReportContentTitle) + 10,
                                 ScreenWidth - 10, 20)];
    MonthlyReportContent.textAlignment = NSTextAlignmentLeft;
    MonthlyReportContent.text = content;
    if (![content isEqualToString:@""]) {
      MonthlyReportContent.numberOfLines = 0;
      [MonthlyReportContent sizeToFit];
    }
    [self addSubview:MonthlyReportContent];
    UILabel *MonthlyReportContentline = [[UILabel alloc]
        initWithFrame:CGRectMake(0, YH(MonthlyReportContent) + 5, ScreenWidth,
                                 1)];
    MonthlyReportContentline.backgroundColor = [UIColor lightGrayColor];
      [self addSubview:MonthlyReportContentline];
    self.frame = CGRectMake(X(self), Y(self), ScreenWidth, YH(MonthlyReportContentline));
  }
  return self;
}

@end
