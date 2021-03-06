//
//  AppDelegate.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/14.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "MessageRequest.h"
#import "MessageViewController.h"
#import "PersonalViewController.h"
#import "ViewController.h"

// JPush
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate () <JPUSHRegisterDelegate, BMKLocationServiceDelegate> {
  BMKLocationService *_locService;
  NSString *_latitude;
  NSString *_longitude;
}

@end
static NSTimer *timer;
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window.backgroundColor = [UIColor whiteColor];
    
  [GiFHUD setGifWithImageName:@"load1.gif"];//设置加载图片
  [self baiduAPI]; //百度地图
    
  //监听极光登录成功
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(networkDidLogin)
             name:kJPFNetworkDidLoginNotification
           object:nil];

  [self UUID]; //设备号

  //极光推送相关
  JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
  entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge |
                 JPAuthorizationOptionSound;
  if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    //可以添加自定义categories
    //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
    //      NSSet<UNNotificationCategory *> *categories;
    //      entity.categories = categories;
    //    }
    //    else {
    //      NSSet<UIUserNotificationCategory *> *categories;
    //      entity.categories = categories;
    //    }
  }
  [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

  //初始化JPush
  //如不需要使用IDFA，advertisingIdentifier 可为nil
  [JPUSHService setupWithOption:launchOptions
                         appKey:@"023b08c13c84e501e0165ac2"
                        channel:channel
               apsForProduction:isProduction
          advertisingIdentifier:nil];

  [self createController]; //创建tabbar

  [self unreadNumber]; //未读信息个数

  if (UDOBJ(ZToken)) { //已经登录
    //    self.window.rootViewController = _tabBar;
    [self slideRoot];
  } else {
    UINavigationController *nVC = [[UINavigationController alloc]
        initWithRootViewController:[ViewController alloc]];
    self.window.rootViewController = nVC;
  }
  return YES;
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
          withCompletionHandler:(void (^)(NSInteger))completionHandler {
  }
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
    didReceiveNotificationResponse:(UNNotificationResponse *)response
             withCompletionHandler:(void (^)())completionHandler {

}
//极光登录成功
- (void)networkDidLogin{
  NSLog(@"已登录");
  NSString *registID = [JPUSHService registrationID];
  UDSETOBJ(registID, @"registID");
  [[NSUserDefaults standardUserDefaults] synchronize];
    if (UDOBJ(ZToken)) {
        if ([UDOBJ(@"haveBieMing") isEqualToString:@"Y"]) {
            //已经存在别名了,不需要设置了
            NSLog(@"已经存在别名了,不需要设置了");
        }
        else{
            //推送修改别名
            [JPUSHService setTags:nil alias:UDOBJ(@"collegeName") fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
                if (iResCode == 0) {//存在别名，设置成功
                    UDSETOBJ(@"Y", @"haveBieMing");
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else{
                    UDSETOBJ(@"N", @"haveBieMing");
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
            }];
        }
    }
}

//未读消息数目
- (void)unreadNumber {
  if (UDOBJ(ZToken)) { // token存在,去获取未读信息的数量
    [MessageRequest
        unreadMessageNumberRequestWithCompletionBlack:^(NSDictionary *dic) {
          if ([dic[@"status"] intValue] == 200) {
            if ([dic[@"data"] intValue] != 0) {
              [self sendNoti];
              [_tabBar.tabBar showBadgeOnItemIndex:1];
            }
          } else {
            KOMG(dic[@"msg"]);
          }
    }];
  }
}

#pragma mark 定位开启
- (void)upLoadpositionsave {
  _locService = [[BMKLocationService alloc] init];
  _locService.delegate = self;
  //启动LocationService
  [_locService startUserLocationService];
  [self UpLoadCoordinates];
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
  _latitude = [NSString
      stringWithFormat:@"%f", userLocation.location.coordinate.latitude];
  _longitude = [NSString
      stringWithFormat:@"%f", userLocation.location.coordinate.longitude];
}
- (void)UpLoadCoordinates {
  dispatch_queue_t mainQueue = dispatch_get_main_queue();
  dispatch_async(mainQueue, ^{
    timer = [NSTimer scheduledTimerWithTimeInterval:300.0
                                             target:self
                                           selector:@selector(addone)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
  });
}
#pragma mark 紧急定位更新
- (void)addone {
  if (UDOBJ(ZToken) && UDOBJ(ZRegistID)) {
    [[HttpTool sharedInstance] postWithUrl:student_positionsave
        parameters:@{
          @"app_token" : UDOBJ(ZToken),
          @"client" : DEVICEUUID,
          @"longitude" : _longitude,
          @"latitude" : _latitude,
          @"registerId" : UDOBJ(ZRegistID)
        }
        sucess:^(id json) {
        }
        failur:^(NSError *error) {
          KOMG(kHttpError);
        }];
  }
}
#pragma mark 定时器滞空
- (void)TimerTheAir {
  [timer invalidate];
  timer = nil;
}
#pragma mark 一键呼救
- (void)StudentHelp {
  [[HttpTool sharedInstance] postWithUrl:student_help
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID,
        @"longitude" : _longitude,
        @"latitude" : _latitude,
      }
      sucess:^(id json) {

      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }];
}
#pragma mark 加载侧滑界面
- (void)slideRoot {
  _slide = [[SlideRootViewController alloc]
         initWithLeftVC:[PersonalViewController new]
                 mainVC:_tabBar
      slideTranslationX:80];
  UINavigationController *nav =
      [[UINavigationController alloc] initWithRootViewController:_slide];
  nav.navigationBarHidden = YES;
  self.window.rootViewController = nav;
  [self upLoadpositionsave];
}

#pragma mark 百度地图
- (void)baiduAPI {
  _mapManager = [[BMKMapManager alloc] init];
  // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
  BOOL ret = [_mapManager start:@"UNypGZdhGwwZnUbqSYCuCD7N9DS97gAh"
                generalDelegate:nil];
  if (!ret) {
    NSLog(@"manager start failed!");
  }
}
- (void)createController {
  _tabBar = [[UITabBarController alloc] init];
  _tabBar.tabBar.backgroundColor = [UIColor whiteColor];
  _tabBar.tabBar.translucent = NO;
  _tabBar.viewControllers = [self createTabBarItems];
  _tabBar.selectedIndex = 0;
}

- (NSArray *)createTabBarItems {
  UINavigationController *navc1 = [[UINavigationController alloc]
      initWithRootViewController:[[MessageViewController alloc] init]];
  navc1.navigationBarHidden = YES;
  navc1.automaticallyAdjustsScrollViewInsets = NO;
  navc1.tabBarItem.title = @"消息";
  navc1.tabBarItem.image = [UIImage imageNamed:@"tab_message_gray"];
  navc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_message_blue"]
      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

  UINavigationController *navc2 = [[UINavigationController alloc]
      initWithRootViewController:[[HomePageViewController alloc] init]];
  navc2.navigationBarHidden = YES;
  navc2.automaticallyAdjustsScrollViewInsets = NO;
  navc2.tabBarItem.title = @"主页";
  navc2.tabBarItem.image = [UIImage imageNamed:@"tab_home_gray"];
  navc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_home_blue"]
      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

  //  UINavigationController *navc3 = [[UINavigationController alloc]
  //      initWithRootViewController:[[PersonalViewController alloc] init]];
  //  navc3.navigationBarHidden = YES;
  //  navc3.automaticallyAdjustsScrollViewInsets = NO;
  //  navc3.tabBarItem.title = @"我的";
  //  navc3.tabBarItem.image = [UIImage imageNamed:@"tab_person_gray"];
  //  navc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_person_blue"]
  //      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

  return @[
    navc2,
    navc1,
  ];
}
#pragma mark 存储设备号
- (void)UUID {
  if (!UDOBJ(@"DeviceUUID")) {
    NSString *DeviceUUID = [self uuid];
    UDSETOBJ(DeviceUUID, @"DeviceUUID");
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}
#pragma mark 获取设备号
- (NSString *)uuid {
  CFUUIDRef puuid = CFUUIDCreate(nil);
  CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
  NSString *result =
      (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
  CFRelease(puuid);
  CFRelease(uuidString);
  return result;
}
- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state.
  // This can occur for certain types of temporary interruptions (such as an
  // incoming phone call or SMS message) or when the user quits the application
  // and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down
  // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)application:(UIApplication *)application
    didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  // Optional
  NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate
  // timers, and store enough application state information to restore your
  // application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called
  // instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state;
  // here you can undo many of the changes made on entering the background.

  [self unreadNumber];

//  [application setApplicationIconBadgeNumber:0];
//  [application cancelAllLocalNotifications];
}

- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  /// Required - 注册 DeviceToken
  NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
  [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo
          fetchCompletionHandler:
              (void (^)(UIBackgroundFetchResult))completionHandler {

  [JPUSHService handleRemoteNotification:userInfo];
  NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
  completionHandler(UIBackgroundFetchResultNewData);

  if ([UIApplication sharedApplication].applicationState ==
      UIApplicationStateActive) { //在前台时
    NSLog(@"现在是在前台");
//      KOMG(@"有一条新消息");
    [_tabBar.tabBar showBadgeOnItemIndex:1]; //展示小红点
    [self sendNoti]; //发送消息界面刷新通知
  }
}

- (void)sendNoti { //发送通知
  [[NSNotificationCenter defaultCenter] postNotificationName:@"newMessage"
                                                      object:self
                                                    userInfo:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the
  // application was inactive. If the application was previously in the
  // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if
  // appropriate. See also applicationDidEnterBackground:.
}

- (NSString *)logDic:(NSDictionary *)dic {
  if (![dic count]) {
    return nil;
  }
  NSString *tempStr1 =
      [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                   withString:@"\\U"];
  NSString *tempStr2 =
      [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
  NSString *tempStr3 =
      [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
  NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
  NSString *str =
      [NSPropertyListSerialization propertyListFromData:tempData
                                       mutabilityOption:NSPropertyListImmutable
                                                 format:NULL
                                       errorDescription:NULL];
  return str;
}

@end
