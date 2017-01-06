//
//  MessageDetailViewController.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/22.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *myWebview;
@end

@implementation MessageDetailViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self tabBarHidden];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [GiFHUD dismiss];//取消加载
    [self tabBarShow];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _myWebview = [[UIWebView alloc]
                  initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _myWebview.delegate = self;
    _myWebview.scrollView.bounces = NO;
    _myWebview.scrollView.showsVerticalScrollIndicator = NO;
    
    [self addNavigationHeadBackImage];
    [self addtitleWithString:@"通知详情"];
    [self addBackButton];
    
    
    
    [GiFHUD show];//加载动画
    
    
    //解决黑条问题
    //    _myWebview.opaque = NO;
    //    _myWebview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_myWebview];
    NSString *urlStr = [NSString stringWithFormat:@"%@?app_token=%@",_url,UDOBJ(ZToken)];
    [_myWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载完毕");
    [GiFHUD dismiss];//取消加载
    //未读的做回调
    if ([_isRead isEqualToString:@"N"]) {
        _freshBlock();
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [GiFHUD dismiss];//取消加载
    NSLog(@"error ====== %@",error);
}

@end
