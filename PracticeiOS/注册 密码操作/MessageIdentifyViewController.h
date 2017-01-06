//
//  MessageIdentifyViewController.h
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/15.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
@interface MessageIdentifyViewController : BaseViewController
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, assign) BOOL LogInOut;
@property(nonatomic, copy) NSString *flag;
@property(nonatomic, copy) NSString *TitleCode;
@end
