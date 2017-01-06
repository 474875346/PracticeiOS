//
//  SigInViewController.h
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/20.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "BaseViewController.h"

@interface SigInViewController
    : BaseViewController <BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate,
                          BMKMapViewDelegate, UITextViewDelegate>
//定位
@property(nonatomic, retain) BMKLocationService *locService;
//反地理编码
@property(nonatomic, retain) BMKGeoCodeSearch *searcher;
//地图
@property(nonatomic, retain) BMKMapView *mapView;
//经度
@property(nonatomic, copy) NSString *longitude;
//纬度
@property(nonatomic, copy) NSString *latitude;
//位置描述
@property(nonatomic, copy) NSString *positionDescn;
//备注
@property(nonatomic, retain) UITextView *note;
//月报placeHolderLabel
@property(nonatomic, strong) UILabel *placeHolderLabel;
//位置描述标签
@property(nonatomic, retain) UILabel *descnLabel;
//滑动视图
@property(nonatomic, retain) UIScrollView *myScrollview;
//签到显示标签
@property(nonatomic, retain) UILabel *SignInLabel;
//签到按钮
@property(nonatomic, retain) UIButton *SignIn;
//备注标签
@property(nonatomic,retain)UILabel * noteLabel;
@end
