//
//  MessageIdentifyViewController.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/15.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "MessageIdentifyViewController.h"
#import "Common.h"
#import "InputPasswordViewController.h"
#import "RegisterAndPasswordRequest.h"

@interface MessageIdentifyViewController () <UITextFieldDelegate> {
  NSMutableArray *_buttonArray;
  UIButton *_codeButton;
  UITextField *_hiddenTF;
  UIButton *_inputButton;
}
@end

@implementation MessageIdentifyViewController

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:YES];
  [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:YES];
  [_hiddenTF becomeFirstResponder];
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
    [self addtitleWithString:@"填写验证码"];
    [self addBackButton];
  }
  else{
      self.title = @"填写验证码";
      self.view.backgroundColor = [UIColor whiteColor];
      self.automaticallyAdjustsScrollViewInsets = NO;
  }
  
  //数组初始化
  _buttonArray = [[NSMutableArray alloc] init];

  //最上方隐藏的TF
  _hiddenTF =
      [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
  _hiddenTF.textColor = [UIColor clearColor];
  _hiddenTF.backgroundColor = [UIColor clearColor];

  [_hiddenTF addTarget:self
                action:@selector(textChange)
      forControlEvents:UIControlEventEditingChanged];
  [self.view addSubview:_hiddenTF];

  //已发送label
  UILabel *titleLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(0.15 * SCREEN_WIDTH, 100,
                                                0.7 * SCREEN_WIDTH, 30)];
  titleLabel.text =
      [NSString stringWithFormat:@"验证码已发送到手机: %@", _phone];
  titleLabel.textAlignment = 1;
  titleLabel.font = [UIFont systemFontOfSize:13];
  [self.view addSubview:titleLabel];

  //创建4个button
  for (int i = 0; i < 6; i++) {
    float space = 0.1 * SCREEN_WIDTH / 5;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =
        CGRectMake(0.15 * SCREEN_WIDTH + (space + 0.1 * SCREEN_WIDTH) * i, 150,
                   0.1 * SCREEN_WIDTH, 0.1 * SCREEN_WIDTH);
    [button addTarget:self
                  action:@selector(btnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:IMG(@"border_gray")
                      forState:UIControlStateNormal];
    [button setBackgroundImage:IMG(@"border_blue")
                      forState:UIControlStateSelected];
    if (i == 0) {
      button.selected = YES;
      _inputButton = button;
    }
    [self.view addSubview:button];
    [_buttonArray addObject:button];
  }

  //下一步button
  UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
  nextButton.frame = CGRectMake(0.05 * SCREEN_WIDTH, 170 + 0.15 * SCREEN_WIDTH,
                                0.9 * SCREEN_WIDTH, 40);
  nextButton.layer.cornerRadius = 5;
  nextButton.clipsToBounds = YES;
  nextButton.alpha = 0.3;
  nextButton.userInteractionEnabled = NO;
  [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
  nextButton.backgroundColor = COLOR(76, 171, 253, 1);
  [self.view addSubview:nextButton];

  //重新发送短信Button
  _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _codeButton.center = CGPointMake(SCREEN_WIDTH / 2, YH(nextButton) + 30);
  _codeButton.bounds = CGRectMake(0, 0, 100, 30);
  _codeButton.backgroundColor = [UIColor whiteColor];
  [_codeButton addTarget:self
                  action:@selector(getCode)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_codeButton];
  [self Countdown];
}

//倒计时
- (void)Countdown {
  __block int timeout = 29; //倒计时时间
  dispatch_queue_t queue =
      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_source_t _timer =
      dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
  dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0),
                            1.0 * NSEC_PER_SEC, 0); //每秒执行
  dispatch_source_set_event_handler(_timer, ^{
    if (timeout <= 0) { //倒计时结束，关闭
      dispatch_source_cancel(_timer);
      dispatch_async(dispatch_get_main_queue(), ^{
        //设置界面的按钮显示 根据自己需求设置
        [_codeButton setTitle:@"重发短信" forState:UIControlStateNormal];
        _codeButton.userInteractionEnabled = YES;
        [_codeButton setTitleColor:COLOR(76, 171, 253, 1)
                          forState:UIControlStateNormal];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:15];
      });
    } else {
      int seconds = timeout % 30;
      NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
      dispatch_async(dispatch_get_main_queue(), ^{
        //设置界面的按钮显示 根据自己需求设置
        // NSLog(@"____%@",strTime);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [_codeButton
            setTitle:[NSString stringWithFormat:@"%@秒后重新发送", strTime]
            forState:UIControlStateNormal];
        [UIView commitAnimations];
        _codeButton.userInteractionEnabled = NO;
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_codeButton setTitleColor:[UIColor lightGrayColor]
                          forState:UIControlStateNormal];
      });
      timeout--;
    }
  });
  dispatch_resume(_timer);
}
//重新获取验证码
- (void)getCode {
  [RegisterAndPasswordRequest
      getMessageCodeRequestWithPhone:_phone
                                flag:@"0"
                 WithCompletionBlack:^(NSDictionary *dic) {
                   if ([[dic objectForKey:@"status"] intValue] == 200) {
                     NSLog(@"重新获取验证码成功");
                     [self Countdown];
                   } else {
                     KOMG(dic[@"msg"]);
                   }
                 }];
}
// tf获取监听
- (void)btnClick:(UIButton *)button {
  [_hiddenTF becomeFirstResponder];
}
//内容发生变化时
- (void)textChange {

  //如果不是数字,提示并取当前已有内容,return
  if ([self isNumber] == NO) {
    KOMG(@"验证码只能输入数字");
    _hiddenTF.text =
        [_hiddenTF.text substringToIndex:_hiddenTF.text.length - 1];
    return;
  }

  //全赋一遍空
  for (UIButton *oldButton in _buttonArray) {
    [oldButton setTitle:@"" forState:UIControlStateNormal];
  }

  NSString *temp = nil;
  for (int i = 0; i < [_hiddenTF.text length]; i++) {
    temp = [_hiddenTF.text substringWithRange:NSMakeRange(i, 1)];
    NSLog(@"第%d个字是:%@", i, temp);
    UIButton *button = _buttonArray[i];
    [button setTitle:temp forState:UIControlStateNormal];
  }
  if (_hiddenTF.text.length == 6) {
    //发送验证请求
    NSLog(@"发送验证请求");
    [RegisterAndPasswordRequest
        verifyMessageCodeRequestWithPhone:_phone
                          WithMessageCode:_hiddenTF.text
                      WithCompletionBlack:^(NSDictionary *dic) {
                        if ([[dic objectForKey:@"status"] intValue] == 200) {
                          //跳转输入密码界面
                          InputPasswordViewController *passwordVC =
                              [[InputPasswordViewController alloc] init];
                          passwordVC.phone = _phone;
                          passwordVC.code = dic[@"data"];
                            if (_LogInOut) {
                                passwordVC.LogInOut = YES;
                            }
                          passwordVC.TitleCode = _TitleCode;
                          [self.navigationController
                              pushViewController:passwordVC
                                        animated:YES];
                        } else {
                          KOMG(dic[@"msg"])
                        }

                        //清空
                        for (UIButton *oldButton in _buttonArray) {
                          [oldButton setTitle:@""
                                     forState:UIControlStateNormal];
                        }
                        //重新赋值
                        _hiddenTF.text = @"";
                        UIButton *firstButton = _buttonArray[0];
                        _inputButton.selected = NO;
                        firstButton.selected = YES;
                        _inputButton = firstButton;

                      }];
  } else {
    //改变颜色位置
    UIButton *button = _buttonArray[_hiddenTF.text.length];
    _inputButton.selected = NO;
    button.selected = YES;
    _inputButton = button;
  }
}

//验证是否是数字
- (BOOL)isNumber {
  //正则条件
  NSString *number = @"^[0-9]";
  NSPredicate *numberPre =
      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
  //最后一个字符
  NSString *lastStr =
      [_hiddenTF.text substringFromIndex:_hiddenTF.text.length - 1];
  NSLog(@"last ===== %@", lastStr);
  if ([numberPre evaluateWithObject:lastStr]) {
    return YES;
  } else {
    return NO;
  }
}

@end
