//
//  HttpTool.h
//  FoodSafetyAssistant
//
//  Created by 新龙科技 on 16/8/11.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "AFNetworking.h"
#import "Common.h"
#import "URL.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <sys/utsname.h>

@interface HttpTool : NSObject
typedef void (^BaseHttpToolSucess)(id json);
typedef void (^BaseHttpToolFailur)(NSError *error);
typedef void (^BaseHttpProgress)(NSInteger progressNum);
@property(nonatomic,retain)AFHTTPSessionManager *manager;
+ (HttpTool *)sharedInstance;

/**
 *  普通的 post 请求
 *
 *  @param url        接口地址 Url
 *  @param parameters 请求参数
 *  @param sucess     成功后的回调
 *  @param failur     失败后的回调
 */
- (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)parameters
             sucess:(BaseHttpToolSucess)sucess
             failur:(BaseHttpToolFailur)failur;

/**
 *  普通的 get 请求
 *
 *  @param url        接口地址 Url
 *  @param parameters 请求参数
 *  @param sucess     成功后的回调
 *  @param failur     失败后的回调
 */
- (void)getWithUrl:(NSString *)url
        parameters:(NSDictionary *)parameters
            sucess:(BaseHttpToolSucess)sucess
            failur:(BaseHttpToolFailur)failur;

/**
 *  上传图片
 *
 *  @param image  图片数#import "URL.h"组
 *  @param sucess 成功回调
 *  @param failur 失败回调
 *
 *  @return 返回请求线程（进度条）
 */
- (void)postImage:(NSArray *)image
       parameters:(NSDictionary *)parameters
              url:(NSString *)url
           sucess:(BaseHttpToolSucess)sucess
           failur:(BaseHttpToolFailur)failur
      andProgress:(BaseHttpProgress)progress;

/**
 *  删除请求
 *
 *  @param url        接口地址 Url
 *  @param parameters 请求参数
 *  @param sucess     成功后的回调
 *  @param failur     失败后的回调
 */
- (void)DeleteWithUrl:(NSString *)url
           parameters:(NSDictionary *)parameters
               sucess:(BaseHttpToolSucess)sucess
               failur:(BaseHttpToolFailur)failur;

/**
 *  普通的 put 请求
 *
 *  @param url        接口地址 Url
 *  @param parameters 请求参数
 *  @param sucess     成功后的回调
 *  @param failur     失败后的回调
 */
- (void)putWithUrl:(NSString *)url
        parameters:(NSDictionary *)parameters
            sucess:(BaseHttpToolSucess)sucess
            failur:(BaseHttpToolFailur)failur;
#pragma mark 上传视频
/**
 *url 服务器地址
 * parameters 字典 token
 * fileData 要上传的数据
 * name 服务器参数名称 后台给你
 * fileName 文件名称 图片:xxx.jpg,xxx.png 视频:video.mov
 * mimeType 文件类型 图片:image/jpg,image/png 视频:video/quicktime
 * lengthTime 视频时间
 * progress
 * success
 * failure
 */
- (void)upLoadToUrlString:(NSString *)url
               parameters:(NSDictionary *)parameters
                 fileData:(NSMutableArray *)fileData
                 mimeType:(NSMutableArray *)mimeType
                 progress:(void (^)(NSProgress *))progress
                  success:(void (^)(NSURLSessionDataTask *, id))success
                  failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
/**
 判断网络状态
 **/
- (void)startMonitoring;
/**
 获取ipv6地址
 **/
+ (NSString *)formatIPV6Address:(struct in6_addr)ipv6Addr;
/**
 获取ipv4地址
 **/
+ (NSString *)getIPAddress;
//获取设备型号
+ (NSString *)iphoneType;
@end
