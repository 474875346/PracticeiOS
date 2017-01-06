//
//  PersonalModel.h
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/19.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonalData;
@interface PersonalModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) PersonalData *data;

@property (nonatomic, assign) int status;

@end
@interface PersonalData : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *emergencyContact;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *accessToken;

@property (nonatomic, copy) NSString *secret;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *teacherName;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *idCard;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *teacherContact;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, strong) NSArray *studentHeads;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *post;

@end

