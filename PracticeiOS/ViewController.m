//
//  ViewController.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/14.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Common.h"
#import "InputphoneViewController.h"
#import "LabelAndTFView.h"
// JPush
// 引入JPush功能所需头文件
#import "JPUSHService.h"

@interface ViewController () {
  UITextField *_accountTF;
  UITextField *_passwordTF;
  UIImageView *_iconView;
}

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
  self.navigationController.navigationBar.hidden = YES;
  if (_LogInOut) {
    [self tabBarHidden];
  }
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:YES];
  self.navigationController.navigationBar.hidden = NO;
  if (_LogInOut) {
    [self tabBarShow];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _iconView = [[UIImageView alloc] init];
  _iconView.center = CGPointMake(SCREEN_WIDTH / 2, 120);
  _iconView.bounds = CGRectMake(0, 0, 80, 80);
  _iconView.image = IMG(@"iconview");
  _iconView.layer.cornerRadius = 30;
  _iconView.clipsToBounds = YES;
  [self.view addSubview:_iconView];
  //输入view
  LabelAndTFView *view = [[LabelAndTFView alloc]
             initWithFrame:CGRectMake(0.05 * SCREEN_WIDTH, 200,
                                      0.9 * SCREEN_WIDTH, 80)
       WithLabelTitleArray:@[ @"手机", @"密码" ]
      WithPlaceholderArray:@[ @"请输入手机号", @"请输入密码" ]];
  _accountTF = view.TFArray[0];
  _passwordTF = view.TFArray[1];
  [self.view addSubview:view];
  //登录button
  UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
  logInButton.frame =
      CGRectMake(ScreenWidth * 0.05, 315, ScreenWidth * 0.9, 40);
  logInButton.backgroundColor = COLOR(76, 171, 253, 1);
  [logInButton setTitle:@"登录" forState:UIControlStateNormal];
  [logInButton setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateNormal];
  logInButton.layer.cornerRadius = 5;
  logInButton.clipsToBounds = YES;
  [logInButton addTarget:self
                  action:@selector(userLogIn)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:logInButton];
  //忘记密码button
  UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
  forgetButton.frame = CGRectMake(0.95 * ScreenWidth - 80, 365, 80, 40);
  [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
  forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
  [forgetButton setTitleColor:COLOR(76, 171, 253, 1)
                     forState:UIControlStateNormal];
  [forgetButton addTarget:self
                   action:@selector(retrievePSW)
         forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:forgetButton];
  //注册button
  UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
  registerButton.frame = CGRectMake(ScreenWidth * 0.05, 365, 80, 40);
  [registerButton setTitle:@"新用户注册" forState:UIControlStateNormal];
  registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
  [registerButton setTitleColor:COLOR(76, 171, 253, 1)
                       forState:UIControlStateNormal];
  [registerButton addTarget:self
                     action:@selector(registerNumber)
           forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:registerButton];
}
#pragma mark 登录
- (void)userLogIn {
  [self LoadData];
}
#pragma mark 登录请求
- (void)LoadData {
  if ([_accountTF.text isEqualToString:@""]) {
    KOMG(@"用户名不能为空!");
    return;
  }
  if ([_passwordTF.text isEqualToString:@""]) {
    KOMG(@"密码不能为空!");
    return;
  }
  [[HttpTool sharedInstance] postWithUrl:Login
      parameters:@{
        @"client" : DEVICEUUID,
        @"phone" : _accountTF.text,
        @"password" : _passwordTF.text
      }
      sucess:^(id json) {
        if ([json[@"status"] intValue] == 200) {
          UDSETOBJ(json[@"data"][@"access_token"], ZToken);
          UDSETOBJ(json[@"data"][@"refresh_token"], ZRefresh_token);
          UDSETOBJ(json[@"data"][@"collegeName"], @"collegeName");
          [[NSUserDefaults standardUserDefaults] synchronize];
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
            AppDelegate *delegate =
            (AppDelegate *)[[UIApplication sharedApplication] delegate];
          if (_LogInOut) {
            delegate.slide.mainV.selectedIndex = 0;
              [delegate upLoadpositionsave];
            [self.navigationController popToRootViewControllerAnimated:YES];
          } else {
            [delegate slideRoot];
          }
        } else {
          KOMG(json[@"msg"]);
        }
      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }];
}
#pragma mark 注册
- (void)registerNumber {
  InputphoneViewController *InputPhone =
      [[InputphoneViewController alloc] init];
  if (_LogInOut) {
    InputPhone.LogInOut = YES;
  }
  InputPhone.TitleCode = @"注册";
  [self.navigationController pushViewController:InputPhone animated:YES];
}
#pragma mark 找回密码
- (void)retrievePSW {
  InputphoneViewController *InputPhone =
      [[InputphoneViewController alloc] init];
  if (_LogInOut) {
    InputPhone.LogInOut = YES;
  }
  InputPhone.TitleCode = @"找回密码";
  [self.navigationController pushViewController:InputPhone animated:YES];
}



@end
