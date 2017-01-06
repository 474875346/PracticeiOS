//
//  RegisterAndPasswordRequest.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/19.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "RegisterAndPasswordRequest.h"

@implementation RegisterAndPasswordRequest
/**
 *  获取验证码
 *
 *  @param phone   手机号
 *  @param myBlock 回调
 */
+ (void)getMessageCodeRequestWithPhone:(NSString *)phone flag:(NSString*)flag
                   WithCompletionBlack:(void (^)(NSDictionary *))myBlock {
  NSString *urlStr =
      [NSString stringWithFormat:@"%@/api/message/send", BASEURL];
  NSDictionary *parameterDic =
      [[NSDictionary alloc] initWithObjectsAndKeys:phone, @"phone",flag,@"flag", nil];
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
/**
 *  短信验证码验证
 *
 *  @param phone       手机号
 *  @param messageCode 验证码
 *  @param myBlock     回调
 */
+ (void)verifyMessageCodeRequestWithPhone:(NSString *)phone
                          WithMessageCode:(NSString *)messageCode
                      WithCompletionBlack:(void (^)(NSDictionary *))myBlock {
  NSString *urlStr =
      [NSString stringWithFormat:@"%@/api/message/verifyCode", BASEURL];
  NSDictionary *parameterDic = [[NSDictionary alloc]
      initWithObjectsAndKeys:phone, @"phone", messageCode, @"code", nil];
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
/**
 *  注册请求
 *
 *  @param phone     手机号
 *  @param name      昵称
 *  @param password  密码
 *  @param verfiCode 验证码私钥
 *  @param myBlock   回调
 */
+ (void)registerNumberRequestWithPhone:(NSString *)phone
                              WithName:(NSString *)name
                          WithPassword:(NSString *)password
                         WithVerfiCode:(NSString *)verfiCode
                         WithCollegeId:(NSString *)collegeId
                   WithCompletionBlack:(void (^)(NSDictionary *))myBlock {
  NSString *urlStr =
      [NSString stringWithFormat:@"%@/api/student/register", BASEURL];
  NSDictionary *parameterDic = [[NSDictionary alloc]
      initWithObjectsAndKeys:phone, @"phone", name, @"name", password,
                             @"password", verfiCode, @"verifyCode",collegeId,@"collegeId" ,nil];
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

+(void)getUniversityNameWithCompletionBlock:(void (^)(NSDictionary *))myBlock{
    NSString *urlStr =
    [NSString stringWithFormat:@"%@/api/college/list", BASEURL];
   
    [self HttpRequestWithUrl:urlStr
               withParameter:nil
            WithSuccessBlock:^(NSDictionary *dic) {
                NSLog(@"+++++%@", dic);
                myBlock(dic);
            }
            WithFailureBlock:^(NSString *str) {
                NSLog(@"%@",str);
                KOMG(kHttpError);
            }];

}

@end
