//
//  RegisterAndPasswordRequest.h
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/19.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "BaseHttpRequset.h"

@interface RegisterAndPasswordRequest : BaseHttpRequset
/**
 *  获取验证码
 *
 *  @param phone   手机号
 *  @param myBlock 回调
 */
+ (void)getMessageCodeRequestWithPhone:(NSString *)phone flag:(NSString*)flag
                   WithCompletionBlack:(void (^)(NSDictionary *))myBlock;
/**
 *  短信验证码验证
 *
 *  @param phone       手机号
 *  @param messageCode 验证码
 *  @param myBlock     回调
 */
+ (void)verifyMessageCodeRequestWithPhone:(NSString *)phone
                          WithMessageCode:(NSString *)messageCode
                      WithCompletionBlack:(void (^)(NSDictionary *dic))myBlock;
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
                   WithCompletionBlack:
                       (void (^)(NSDictionary *dic))myBlock; //注册请求

+(void)getUniversityNameWithCompletionBlock:(void (^)(NSDictionary *dic))myBlock;//获取学院信息

@end
