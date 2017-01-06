//
//  ChangeThePasswordViewController.m
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/26.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "ChangeThePasswordViewController.h"

@interface ChangeThePasswordViewController () {
  UITextField *_oldpswTF;
  UITextField *_newpswTF;
  UITextField *_confirmnewpswTF;
}
@end

@implementation ChangeThePasswordViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addNavigationHeadBackImage];
  [self addtitleWithString:@"修改密码"];
  [self addBackButton];
  [self CreatUI];
}
- (void)CreatUI {
  //原密码和新密码
  LabelAndTFView *View = [[LabelAndTFView alloc]
             initWithFrame:CGRectMake(0.05 * SCREEN_WIDTH, 120,
                                      0.9 * SCREEN_WIDTH, 120)
       WithLabelTitleArray:@[ @"原密码", @"新密码", @"新密码" ]
      WithPlaceholderArray:@[
        @"输入原密码",
        @"输入新密码(最大长度32)",
        @"输入确认新密码(最大长度32)",
      ]];
  _oldpswTF = View.TFArray[0];
  _newpswTF = View.TFArray[1];
  _confirmnewpswTF = View.TFArray[2];
  [_newpswTF addTarget:self
                action:@selector(textFieldDidChange)
      forControlEvents:UIControlEventEditingChanged];
  [_confirmnewpswTF addTarget:self
                       action:@selector(textFieldDidChange)
             forControlEvents:UIControlEventEditingChanged];
  [self.view addSubview:View];
  //修改密码
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.backgroundColor = kColor(76, 171, 253);
  button.frame = CGRectMake(X(View), YH(View) + 30, W(View), 30);
  [button setTitle:@"修改密码" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(ChangeThePsw:)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}
#pragma mark 修改密码
- (void)ChangeThePsw:(UIButton *)btn {
  if ([_oldpswTF.text isEqualToString:@""]) {
    KOMG(@"旧密码 不能为空");
    return;
  }
  if ([_newpswTF.text isEqualToString:@""]) {
    KOMG(@"新密码不能为空");
    return;
  }
  if ([_confirmnewpswTF.text isEqualToString:@""]) {
    KOMG(@"确认新密码不能为空");
    return;
  }
  if (![_newpswTF.text isEqualToString:_confirmnewpswTF.text]) {
    KOMG(@"新密码与确认新密码不相同")
    return;
  }
  [[HttpTool sharedInstance] postWithUrl:student_changePass
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID,
        @"old_password" : _oldpswTF.text,
        @"password" : _newpswTF.text,
        @"re_password" : _confirmnewpswTF.text
      }
      sucess:^(id json) {
        if ([json[@"status"] intValue] == 200) {
          KOMG(@"修改密码成功");
          [self.navigationController popViewControllerAnimated:YES];
        } else {
          KOMG(json[@"msg"]);
        }
      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }];
}
- (void)textFieldDidChange {
  if (_newpswTF.text.length > 20) {
    _newpswTF.text = [_newpswTF.text substringToIndex:20];
    KOMG(@"新密码长度不得超过20个字符")
  }
  if (_confirmnewpswTF.text.length > 20) {
    _confirmnewpswTF.text = [_confirmnewpswTF.text substringToIndex:20];
    KOMG(@"确认新密码长度不得超过20个字符")
  }
}
@end
