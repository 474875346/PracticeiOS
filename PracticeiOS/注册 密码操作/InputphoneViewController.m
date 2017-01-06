//
//  InputphoneViewController.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/15.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "InputphoneViewController.h"
#import "Common.h"
#import "LabelAndTFView.h"
#import "MessageIdentifyViewController.h"
#import "RegisterAndPasswordRequest.h"

@interface InputphoneViewController () <UITextFieldDelegate> {
  UITextField *_phoneTF;
  UIButton *_nextButton;
}
@end

@implementation InputphoneViewController
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self tabBarHidden];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:YES];
  [self.view endEditing:YES];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if ([_TitleCode isEqualToString:@"注册"]) {
    _flag = @"0";
  } else {
    _flag = @"1";
  }
  if (_LogInOut) {
    [self addNavigationHeadBackImage];
    [self addtitleWithString:@"输入手机号"];
    [self addBackButton];
  }
  else{
      self.title = @"输入手机号";
      self.view.backgroundColor = [UIColor whiteColor];
      [[UIBarButtonItem appearance]
       setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
       forBarMetrics:UIBarMetricsDefault];
  }
  

  //输入view
  LabelAndTFView *view =
      [[LabelAndTFView alloc] initWithFrame:CGRectMake(0.05 * SCREEN_WIDTH, 164,
                                                       0.9 * SCREEN_WIDTH, 40)
                        WithLabelTitleArray:@[ @"手机号" ]
                       WithPlaceholderArray:@[ @"请输入手机号" ]];
  _phoneTF = view.TFArray[0];
  [_phoneTF addTarget:self
                action:@selector(textFieldDidChange)
      forControlEvents:UIControlEventEditingChanged];
  [self.view addSubview:view];

  _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _nextButton.frame =
      CGRectMake(0.05 * SCREEN_WIDTH, 234, 0.9 * SCREEN_WIDTH, 40);
  _nextButton.layer.cornerRadius = 5;
  _nextButton.clipsToBounds = YES;
  _nextButton.alpha = 0.3;
  _nextButton.userInteractionEnabled = NO;
  [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
  _nextButton.backgroundColor = COLOR(76, 171, 253, 1);
  [_nextButton addTarget:self
                  action:@selector(nextVC)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_nextButton];
}

- (void)textFieldDidChange {
  //判断是否符合手机规范
  if ([self valiMobile:_phoneTF.text]) {
    _nextButton.alpha = 1;
    _nextButton.userInteractionEnabled = YES;
  } else {
    _nextButton.alpha = 0.3;
    _nextButton.userInteractionEnabled = NO;
  }
}

//判断手机号码格式是否正确
- (BOOL)valiMobile:(NSString *)mobile {
  mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
  if (mobile.length != 11) {
    return NO;
  } else {
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))"
                       @"\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM =
        @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 =
        [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
    NSPredicate *pred2 =
        [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
    NSPredicate *pred3 =
        [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:mobile];

    if (isMatch1 || isMatch2 || isMatch3) {
      return YES;
    } else {
      return NO;
    }
  }
}

- (void)nextVC {
  //获取验证码请求
  [RegisterAndPasswordRequest
      getMessageCodeRequestWithPhone:_phoneTF.text
                                flag:_flag
                 WithCompletionBlack:^(NSDictionary *dic) {
                   if ([[dic objectForKey:@"status"] intValue] == 200) {
                     NSLog(@"获取验证码成功");
                     MessageIdentifyViewController *messageVC =
                         [[MessageIdentifyViewController alloc] init];
                     messageVC.phone = _phoneTF.text;
                     if (_LogInOut) {
                       messageVC.LogInOut = YES;
                     }
                     messageVC.TitleCode = _TitleCode;
                     [self.navigationController pushViewController:messageVC
                                                          animated:YES];
                   } else {
                     KOMG(dic[@"msg"]);
                   }
                 }];
}

@end
