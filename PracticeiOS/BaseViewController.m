//
//  BaseViewController.m
//  JianKangLiClient
//
//  Created by KangYaFei on 15/12/1.
//  Copyright © 2015年 KangYaFei. All rights reserved.
//

#import "BaseViewController.h"

//#import "HomePageViewController.h"

@interface BaseViewController () 
@end
@implementation BaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = kColor(241, 242, 244);
  //    [self addNavigationHeadBackImage];
}
//- (void)viewWillAppear:(BOOL)animated {
//  [super viewWillAppear:animated];
//  [self tabBarShow];
//}
-(void)TimerStar {
    AppDelegate *delegate =
    (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate upLoadpositionsave];
}
-(void)TimerStop {
    AppDelegate *delegate =
    (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate TimerTheAir];
}
-(void)StudentHelp {
    AppDelegate *delegate =
    (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate StudentHelp];
}
- (void)slide {
  AppDelegate *delegate =
      (AppDelegate *)[UIApplication sharedApplication].delegate;
  [delegate.slide slideBack];
}
- (void)addNavigationHeadBackImage {
  UIImageView *image =
      [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
  image.backgroundColor = kColor(76, 171, 253);
  //    image.image=[UIImage imageNamed:@"daohang"];
  self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
  //    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

  [self.view addSubview:image];
}
- (void)addBackButton {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(10, 20, 55, 44);
  //    button.backgroundColor=[UIColor greenColor];
  button.imageEdgeInsets = UIEdgeInsetsMake(12, 10, 12, 35);
  [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}
- (void)back {
  [self.navigationController popViewControllerAnimated:YES];
}
- (void)backToHome {
  //    for (UIViewController *controller in
  //    self.navigationController.viewControllers) {
  //        if ([controller isKindOfClass:[HomePageViewController class]]) {
  //            [self.navigationController popToViewController:controller
  //            animated:YES];
  //        }
  //    }
}
- (void)TheDrawer {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(10, 20, 44, 44);
  //    button.backgroundColor=[UIColor greenColor];
  //    button.imageEdgeInsets = UIEdgeInsetsMake(12, 10, 12, 35);
  [button setImage:[UIImage imageNamed:@"drawer"]
          forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(TheDrawer:)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}
- (void)TheDrawer:(UIButton *)btn {
  AppDelegate *delegate =
      (AppDelegate *)[UIApplication sharedApplication].delegate;
  [delegate.slide slideToLeft];
}
- (void)addtitleWithString:(NSString *)title {

  UILabel *label =
      [[UILabel alloc] initWithFrame:CGRectMake(80, 27, ScreenWidth - 160, 30)];
  label.text = title;
  label.textAlignment = NSTextAlignmentCenter;
  label.font = kFont(21);
  label.textColor = kColor(255, 255, 255);
  [self.view addSubview:label];
}

- (void)tabBarShow {
  AppDelegate *delegate =
      (AppDelegate *)[UIApplication sharedApplication].delegate;
  delegate.tabBar.tabBar.hidden = NO;
  delegate.tabBar.tabBar.translucent = NO;
}

- (void)tabBarHidden {
  AppDelegate *delegate =
      (AppDelegate *)[UIApplication sharedApplication].delegate;
  delegate.tabBar.tabBar.hidden = YES;
  delegate.tabBar.tabBar.translucent = YES;
}
- (void)addchrysanthemum:(NSString *)String {
  self.activityIndicator = [[UIActivityIndicatorView alloc]
      initWithFrame:CGRectMake(ScreenWidth / 2 - 50, ScreenHeight / 2 - 50, 100,
                               100)];
  self.activityIndicator.backgroundColor = [UIColor blackColor];
  self.activityIndicator.alpha = .7;
  self.activityIndicator.layer.cornerRadius = 6;
  self.activityIndicator.layer.masksToBounds = YES;
  self.activityIndicator.activityIndicatorViewStyle = 0;
  [self.view addSubview:self.activityIndicator];
  [self.activityIndicator startAnimating];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
  label.text = String;
  label.font = kFont(14);
  label.textColor = [UIColor whiteColor];
  label.textAlignment = NSTextAlignmentCenter;
  [self.activityIndicator addSubview:label];
}
- (void)addchrysanthemumhidden {
  [self.activityIndicator stopAnimating];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
}
@end
