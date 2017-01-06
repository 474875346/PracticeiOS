//
//  HomePageViewController.h
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/14.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "BaseViewController.h"
#import "MonthlyReporViewController.h"
#import "SigInViewController.h"
#import "SignInRecordViewController.h"
#import "MonthlyRecordViewController.h"
@interface HomePageViewController : BaseViewController
//间距
@property(nonatomic, assign) float spacing;
//签到
@property(nonatomic, retain) UIButton *SignIn;
//月报
@property(nonatomic, retain) UIButton *MonthlyRepor;
//签到记录
@property(nonatomic, retain) UIButton *SignInRecord;
@end
