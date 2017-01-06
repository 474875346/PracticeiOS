//
//  BaseViewController.h
//  JianKangLiClient
//
//  Created by KangYaFei on 15/12/1.
//  Copyright © 2015年 KangYaFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface BaseViewController : UIViewController

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator ;

-(void)backToHome;

-(void)back;

-(void)addNavigationHeadBackImage;

-(void)addBackButton;

-(void)addtitleWithString:(NSString *)title;

-(void)tabBarHidden;

-(void)tabBarShow;

-(void)addchrysanthemum:(NSString*)String;

-(void)addchrysanthemumhidden;

-(void)slide;

-(void)TheDrawer;

-(void)TimerStar;

-(void)TimerStop;

-(void)StudentHelp;
@end
