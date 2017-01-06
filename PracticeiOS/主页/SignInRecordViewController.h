//
//  SignInRecordViewController.h
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/21.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "BaseViewController.h"
#import "SignInRecordModel.h"
#import "SignInRecordTableViewCell.h"
@interface SignInRecordViewController
    : BaseViewController <UITableViewDelegate, UITableViewDataSource>
//模型
@property(nonatomic, retain) SignInRecordModel *SignInRecord;
//表格
@property(nonatomic, retain) UITableView *SignInRecordTableView;
//数据数组
@property(nonatomic, retain) NSMutableArray *DataArray;
//分页数
@property(nonatomic, assign) int pageNumber;
@end
