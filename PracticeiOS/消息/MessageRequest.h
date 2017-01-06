//
//  MessageRequest.h
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/22.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "BaseHttpRequset.h"

@interface MessageRequest : BaseHttpRequset

+(void)messageListRequestWithPageNumber:(NSString *)number WithToken:(NSString *)token WithClient:(NSString *)client WithCompletionBlack:(void (^)(NSDictionary *dic))myBlock;


+(void)unreadMessageNumberRequestWithCompletionBlack:(void (^)(NSDictionary *dic))myBlock;

@end
