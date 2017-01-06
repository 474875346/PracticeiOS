//
//  SigInViewController.m
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/20.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "SigInViewController.h"

@interface SigInViewController ()

@end

@implementation SigInViewController
- (UILabel *)SignInLabel {
  if (_SignInLabel == nil) {
    _SignInLabel = [[UILabel alloc]
        initWithFrame:CGRectMake(ScreenWidth / 2 - ScreenWidth / 6,
                                 YH(_note) + 20, ScreenWidth / 3,
                                 ScreenWidth / 3)];
    _SignInLabel.backgroundColor = kColor(29, 138, 245);
    _SignInLabel.numberOfLines = 2;
    _SignInLabel.textAlignment = NSTextAlignmentCenter;
    _SignInLabel.text = @"签到";
    ViewBorderRadius(_SignInLabel, ScreenWidth / 6, 0, [UIColor clearColor]);
  }
  return _SignInLabel;
}
- (void)viewWillAppear:(BOOL)animated {
  [_mapView viewWillAppear];
  _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
  _locService.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated {
  [_mapView viewWillDisappear];
  _mapView.delegate = nil; // 不用时，置nil
  _locService.delegate = nil;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self addNavigationHeadBackImage];
  [self addtitleWithString:@"签到"];
  [self addBackButton];
  [self CreatUI];
  [self LocationService];
  [self ValidationSigninData];
}
- (void)back {
  [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 布局
- (void)CreatUI {
  _positionDescn = @"   正在定位中.....";
  //滑动视图
  _myScrollview = [[UIScrollView alloc]
      initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
  _myScrollview.bounces = NO;
  [self.view addSubview:_myScrollview];
  //时间
  UILabel *date =
      [[UILabel alloc] initWithFrame:CGRectMake(-1, 30, ScreenWidth + 2, 30)];
  NSDate *currentDate = [NSDate date]; //获取当前时间，日期
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"YYYY-MM-dd"];
  NSString *dateString = [dateFormatter stringFromDate:currentDate];
  date.text = [NSString stringWithFormat:@"   %@", dateString];
  ViewBorderRadius(date, 0, 0.5, [UIColor lightGrayColor]);
  [_myScrollview addSubview:date];
  //定位地点
  _descnLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(-1, YH(date) + 30, ScreenWidth + 2, 30)];
  _descnLabel.text = _positionDescn;
  ViewBorderRadius(_descnLabel, 0, 0.5, [UIColor lightGrayColor]);
  [_myScrollview addSubview:_descnLabel];
  //百度地图
  _mapView = [[BMKMapView alloc]
      initWithFrame:CGRectMake(20, YH(_descnLabel) + 20, ScreenWidth - 40,
                               ScreenWidth / 2)];
  _mapView.showsUserLocation = YES;                      //显示定位图层
  _mapView.userTrackingMode = BMKUserTrackingModeFollow; // 普通定位模式
  _mapView.zoomLevel = 18;
  _mapView.gesturesEnabled = NO;
  [_myScrollview addSubview:_mapView];
  //备注
  _noteLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(20, YH(_mapView) + 20, 80, 30)];
  _noteLabel.text = @"备注";
  _noteLabel.textColor = [UIColor lightGrayColor];
  [_myScrollview addSubview:_noteLabel];
  UISwitch *switchView = [[UISwitch alloc]
      initWithFrame:CGRectMake(ScreenWidth - 80, Y(_noteLabel), 60, 30)];
  [switchView addTarget:self
                 action:@selector(switchView:)
       forControlEvents:UIControlEventValueChanged];
  [_myScrollview addSubview:switchView];
  //描述
  _note = [[UITextView alloc]
      initWithFrame:CGRectMake(20, YH(_noteLabel) + 20, ScreenWidth - 40, 0)];
  _note.delegate = self;
  [_myScrollview addSubview:_note];
  _placeHolderLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(0, 2, W(_note), 30)];
  _placeHolderLabel.text = @"请填写您的备注";
  _placeHolderLabel.font = [UIFont systemFontOfSize:18];
  _placeHolderLabel.textColor = [UIColor lightGrayColor];
  [_note addSubview:_placeHolderLabel];
  //签到标签
  [_myScrollview addSubview:self.SignInLabel];
  //签到
  _SignIn = [UIButton buttonWithType:UIButtonTypeCustom];
  _SignIn.frame = CGRectMake(ScreenWidth / 2 - ScreenWidth / 6, YH(_note) + 20,
                             ScreenWidth / 3, ScreenWidth / 3);
  [_SignIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [_SignIn addTarget:self
                action:@selector(SignIn:)
      forControlEvents:UIControlEventTouchUpInside];
  [_myScrollview addSubview:_SignIn];
  _myScrollview.contentSize = CGSizeMake(SCREEN_WIDTH, YH(_SignIn) + 30);
}
- (void)SignIn:(UIButton *)btn {
  [self SigninData];
}
- (void)switchView:(UISwitch *)view {
  if (view.isOn) {
    _note.frame =
        CGRectMake(20, YH(_noteLabel) + 20, ScreenWidth - 40, ScreenWidth / 2);
    _SignIn.frame =
        CGRectMake(ScreenWidth / 2 - ScreenWidth / 6, YH(_note) + 20,
                   ScreenWidth / 3, ScreenWidth / 3);
    _SignInLabel.frame =
        CGRectMake(ScreenWidth / 2 - ScreenWidth / 6, YH(_note) + 20,
                   ScreenWidth / 3, ScreenWidth / 3);
    _myScrollview.contentSize = CGSizeMake(SCREEN_WIDTH, YH(_SignIn) + 30);
  } else {
    _note.frame = CGRectMake(20, YH(_noteLabel) + 20, ScreenWidth - 40, 0);
    _SignIn.frame =
        CGRectMake(ScreenWidth / 2 - ScreenWidth / 6, YH(_note) + 20,
                   ScreenWidth / 3, ScreenWidth / 3);
    _SignInLabel.frame =
        CGRectMake(ScreenWidth / 2 - ScreenWidth / 6, YH(_note) + 20,
                   ScreenWidth / 3, ScreenWidth / 3);
    _myScrollview.contentSize = CGSizeMake(SCREEN_WIDTH, YH(_SignIn) + 30);
  }
}
#pragma mark placeHolder显示隐藏
- (BOOL)textView:(UITextView *)textView
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString *)text {
  if (![text isEqualToString:@""]) {
    _placeHolderLabel.hidden = YES;
  }
  if ([text isEqualToString:@""] && range.length == 1 && range.location == 0) {
    _placeHolderLabel.hidden = NO;
  }
  return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
  if (![textView.text isEqualToString:@""]) {
    _placeHolderLabel.hidden = YES;
  }
}

#pragma mark 定位
- (void)LocationService {
  //初始化BMKLocationService
  _locService = [[BMKLocationService alloc] init];
  //启动LocationService
  [_locService startUserLocationService];
}
#pragma mark 实现相关delegate 处理位置信息更新。处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
  [_mapView updateLocationData:userLocation];
}
#pragma mark 处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
  [_mapView updateLocationData:userLocation];
  _latitude = [NSString
      stringWithFormat:@"%f", userLocation.location.coordinate.latitude];
  _longitude = [NSString
      stringWithFormat:@"%f", userLocation.location.coordinate.longitude];
  //初始化检索对象
  _searcher = [[BMKGeoCodeSearch alloc] init];
  _searcher.delegate = self;
  CLLocationCoordinate2D pt =
      (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,
                               userLocation.location.coordinate.longitude};
  BMKReverseGeoCodeOption *reverseGeoCodeSearchOption =
      [[BMKReverseGeoCodeOption alloc] init];
  reverseGeoCodeSearchOption.reverseGeoPoint = pt;
  BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
  if (flag) {
    NSLog(@"反geo检索发送成功");
  } else {
    NSLog(@"反geo检索发送失败");
  }
}
#pragma mark 接收反向地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error {
  if (error == BMK_SEARCH_NO_ERROR) {
    _positionDescn = result.address;
    self.descnLabel.text =
        [NSString stringWithFormat:@"    %@", result.address];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
  } else {
    NSLog(@"抱歉，未找到结果");
  }
}
#pragma mark 验证是否签到
- (void)ValidationSigninData {
  [[HttpTool sharedInstance] postWithUrl:student_validSign
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID
      }
      sucess:^(id json) {
        if ([json[@"status"] intValue] == 200) {
          if ([json[@"data"] boolValue] == YES) {
            _SignInLabel.text = @"已签到";
            _SignIn.userInteractionEnabled = NO;
          }
        } else {
          KOMG(json[@"msg"]);
        }
      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }];
}
#pragma mark 签到请求
- (void)SigninData {
  if (_latitude == nil || _longitude == nil) {
    KOMG(@"请先定位");
    return;
  }
  [[HttpTool sharedInstance] postWithUrl:student_signIn
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID,
        @"longitude" : _longitude,
        @"latitude" : _latitude,
        @"descn" : _note.text,
        @"positionDescn" : _positionDescn
      }
      sucess:^(id json) {
        if ([json[@"status"] intValue] == 200) {
          KOMG(@"签到成功");
          [self dismissViewControllerAnimated:YES completion:nil];
        } else {
          KOMG(json[@"msg"]);
        }
      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }];
}
@end
