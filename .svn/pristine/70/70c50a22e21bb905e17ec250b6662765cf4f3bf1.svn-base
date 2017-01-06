//
//  PersonalDataViewController.h
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/20.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "BaseViewController.h"
#import "PersonalDataTableViewCell.h"
#import "PersonalModel.h"
@interface PersonalDataViewController
    : BaseViewController <UITableViewDelegate, UITableViewDataSource,
                          UIImagePickerControllerDelegate,
                          UINavigationControllerDelegate>
//表格
@property(nonatomic, retain) UITableView *PersonalDataTabelView;
//模型
@property(nonatomic, retain) PersonalModel *Personal;
// title数组
@property(nonatomic, retain) NSArray *titleArray;
//昵称
@property(nonatomic, copy) NSString *name;
//性别
@property(nonatomic, copy) NSString *sex;
//校外住址
@property(nonatomic, copy) NSString *address;
//紧急联系方式
@property(nonatomic, copy) NSString *emergencyContact;
//实习单位
@property(nonatomic, copy) NSString *unit;
//实习岗位
@property(nonatomic, copy) NSString *post;
//岗位老师姓名
@property(nonatomic, copy) NSString *teacherName;
//岗位老师电话
@property(nonatomic, copy) NSString *teacherContact;
//相机
@property(nonatomic, retain) UIImagePickerController *picker;
//选择的图片
@property(nonatomic, retain) UIImage *selectedImg;
//选择图片
@property(nonatomic, assign) BOOL isImg;
//保存按钮
@property(nonatomic, retain) UIButton *SaveButton;
//回调
@property(nonatomic, copy) void (^PersonalData)();
@end
