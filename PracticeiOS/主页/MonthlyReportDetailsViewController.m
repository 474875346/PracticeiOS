//
//  MonthlyReportDetailsViewController.m
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/30.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "MonthlyReportDetailsViewController.h"
#import "ImageScrollview.h"

@interface MonthlyReportDetailsViewController () {
  UIButton *selectButton;
  UIButton *PlayerView;
  NSURL *url;
}
@end

@implementation MonthlyReportDetailsViewController

- (NSMutableArray *)imageArray {
  if (_imageArray == nil) {
    _imageArray = [[NSMutableArray alloc] init];
  }
  return _imageArray;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self addNavigationHeadBackImage];
  [self addtitleWithString:@"月报详情"];
  [self addBackButton];
  [self CreatUI];
}
- (void)back {
  [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 布局
- (void)CreatUI {
  _myScrollview = [[UIScrollView alloc]
      initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
  _myScrollview.bounces = NO;
  [self.view addSubview:_myScrollview];
  _plan = [[MonthlyReportView alloc]
      initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)
         TitleArray:@"工作计划:"
       ContentArray:_monthlyrecord.plan];
  [_myScrollview addSubview:_plan];
  _summary = [[MonthlyReportView alloc]
      initWithFrame:CGRectMake(0, YH(_plan), ScreenWidth, 100)
         TitleArray:@"工作总结:"
       ContentArray:_monthlyrecord.summary];
  [_myScrollview addSubview:_summary];
  _MonthlyReportContent = [[MonthlyReportView alloc]
      initWithFrame:CGRectMake(0, YH(_summary), ScreenWidth, 100)
         TitleArray:@"备注:"
       ContentArray:_monthlyrecord.descn];
  [_myScrollview addSubview:_MonthlyReportContent];

  float picSpace = SCREEN_WIDTH * 0.25 / 6;
  [_monthlyrecord.files enumerateObjectsUsingBlock:^(
                            MonthlyRecordFiles *_Nonnull obj, NSUInteger idx,
                            BOOL *_Nonnull stop) {
    if ([obj.ext isEqualToString:@"mp4"]) {
      selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
      selectButton.frame =
          CGRectMake(0, YH(_MonthlyReportContent) + 10, 0, 0.15 * SCREEN_WIDTH);
      [_myScrollview addSubview:selectButton];
      PlayerView = [UIButton buttonWithType:UIButtonTypeCustom];
      PlayerView.frame =
          CGRectMake(10, YH(selectButton) + 10, ScreenWidth - 15, 200);
      [PlayerView addTarget:self
                     action:@selector(Player:)
           forControlEvents:UIControlEventTouchUpInside];
      [_myScrollview addSubview:PlayerView];
      NSURL *URL = [NSURL URLWithString:obj.path];
      url = URL;
      AVPlayer *player = [AVPlayer playerWithURL:URL];
      AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
      playerLayer.frame = CGRectMake(0, 0, W(PlayerView), H(PlayerView));
      [PlayerView.layer addSublayer:playerLayer];
      [player play];
      _myScrollview.contentSize = CGSizeMake(0, YH(PlayerView) + 10);
    } else {
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      button.frame =
          CGRectMake(picSpace + (0.15 * SCREEN_WIDTH + picSpace) * idx,
                     YH(_MonthlyReportContent) + 10, 0.15 * SCREEN_WIDTH,
                     0.15 * SCREEN_WIDTH);
      button.backgroundColor = [UIColor clearColor];
      button.tag = idx;
      [button addTarget:self
                    action:@selector(showImage:)
          forControlEvents:UIControlEventTouchUpInside];
      [button sd_setImageWithURL:[NSURL URLWithString:obj.path]
                        forState:UIControlStateNormal
                placeholderImage:[UIImage imageNamed:@"iconview"]];
      [_myScrollview addSubview:button];
      [self.imageArray addObject:obj.path];
      selectButton = button;
      _myScrollview.contentSize = CGSizeMake(0, YH(selectButton) + 10);
    }
  }];
}
#pragma mark 点击进入视频
- (void)Player:(UIButton *)btn {
  PlayerViewController *player = [PlayerViewController new];
  player.modalTransitionStyle = 2;
  player.request = [NSURLRequest requestWithURL:url];
  [self presentViewController:player animated:YES completion:nil];
}
#pragma mark 图片点击放大
- (void)showImage:(UIButton *)button {
  ImageScrollview *imageScrollview = [[ImageScrollview alloc]
       initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)
      WithImageArray:self.imageArray
           WithIndex:button.tag + 1];
  [self.view addSubview:imageScrollview];
  [self.navigationController.navigationBar setHidden:YES];
  imageScrollview.transform = CGAffineTransformMakeScale(
      0.0f, 0.0f); //将要显示的view按照正常比例显示出来
  [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
  [UIView
      setAnimationCurve:
          UIViewAnimationCurveEaseInOut]; // InOut 表示进入和出去时都启动动画
  [UIView setAnimationDuration:0.2f]; //动画时间
  imageScrollview.transform =
      CGAffineTransformMakeScale(1.0f, 1.0f); //先让要显示的view最小直至消失
  [UIView commitAnimations];                  //启动动画
  //相反如果想要从小到大的显示效果，则将比例调换
  __block ImageScrollview *scrollview = imageScrollview;
  imageScrollview.returnBlock = ^{
    [self.navigationController.navigationBar setHidden:NO];
    [scrollview removeFromSuperview];
    scrollview = nil;
  };
}
@end
