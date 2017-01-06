//
//  MonthlyRecordModel.h
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/30.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MonthlyRecordFiles;
@interface MonthlyRecordModel : NSObject

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *descn;

@property (nonatomic, copy) NSString *plan;

@property (nonatomic, strong) NSArray<MonthlyRecordFiles *> *files;

@property (nonatomic, copy) NSString *createTime;

@end

@interface MonthlyRecordFiles : NSObject

@property (nonatomic, assign) NSInteger totalBytes;

@property (nonatomic, copy) NSString *ext;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *type;

@end

