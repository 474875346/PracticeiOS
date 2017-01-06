//
//  PlayerViewController.m
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/30.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  UIWebView *web = [[UIWebView alloc]
      initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
  web.delegate = self;
  [web loadRequest:_request];
  [self.view addSubview:web];

  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(10, 20, 55, 44);
  button.imageEdgeInsets = UIEdgeInsetsMake(12, 10, 12, 35);
  [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
  [web addSubview:button];
}
- (void)back {
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
  webView.mediaPlaybackRequiresUserAction = NO;
}
@end
