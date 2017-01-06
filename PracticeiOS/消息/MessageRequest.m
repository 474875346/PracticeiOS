//
//  MessageRequest.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/22.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "MessageRequest.h"

@implementation MessageRequest

+(void)messageListRequestWithPageNumber:(NSString *)number WithToken:(NSString *)token WithClient:(NSString *)client WithCompletionBlack:(void (^)(NSDictionary *dic))myBlock{
    NSString *urlStr =
    [NSString stringWithFormat:@"%@/api/notice/pageQuery", BASEURL];
    NSDictionary *parameterDic =
    [[NSDictionary alloc] initWithObjectsAndKeys:number, @"pageNumber",@"10",@"pageSize",token,@"app_token",client,@"client",nil];
    [self HttpRequestWithUrl:urlStr
               withParameter:parameterDic
            WithSuccessBlock:^(NSDictionary *dic) {
                NSLog(@"+++++%@", dic);
                myBlock(dic);
            }
            WithFailureBlock:^(NSString *str) {
                KOMG(kHttpError);
                [GiFHUD dismiss];
            }];

}


+(void)unreadMessageNumberRequestWithCompletionBlack:(void (^)(NSDictionary *))myBlock{
    NSString *urlStr =
    [NSString stringWithFormat:@"%@/api/notice/unread", BASEURL];
    NSDictionary *parameterDic =
    [[NSDictionary alloc] initWithObjectsAndKeys:UDOBJ(ZToken),@"app_token",DEVICEUUID,@"client",nil];
    [self HttpRequestWithUrl:urlStr
               withParameter:parameterDic
            WithSuccessBlock:^(NSDictionary *dic) {
                NSLog(@"+++++%@", dic);
                myBlock(dic);
            }
            WithFailureBlock:^(NSString *str) {
                KOMG(kHttpError);
            }];

}
@end
