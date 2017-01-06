//
//  MonthlyRecordModel.m
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/30.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "MonthlyRecordModel.h"

@implementation MonthlyRecordModel

+ (NSDictionary *)objectClassInArray{
    return @{@"files" : [MonthlyRecordFiles class]};
}
@end

@implementation MonthlyRecordFiles

@end


