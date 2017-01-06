//
//  MonthlyReporViewController.h
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/14.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "BaseViewController.h"
#import "KZVideoPlayer.h"
#import "KZVideoViewController.h"
#import "TZImagePickerController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
@interface MonthlyReporViewController
    : BaseViewController <UINavigationControllerDelegate, UITextViewDelegate,
                          TZImagePickerControllerDelegate,
                          KZVideoViewControllerDelegate>
@property(nonatomic,retain) TZImagePickerController *imagePickerVC;
//月报
@property(nonatomic, retain) UITextView *MonthlyReportContent;
//工作总结
@property(nonatomic, retain) UITextView *summary;
//工作计划
@property(nonatomic, retain) UITextView *plan;
//工作计划placeHolderLabel
@property(nonatomic, strong) UILabel *PlanplaceHolderLabel;
//工作总结placeHolderLabel
@property(nonatomic, strong) UILabel *SummaryplaceHolderLabel;
//月报placeHolderLabel
@property(nonatomic, strong) UILabel *placeHolderLabel;
//滑动视图
@property(nonatomic, strong) UIScrollView *myScrollview;
//提交按钮
@property(nonatomic, strong) UIButton *submitButton;
//图片按钮数组
@property(nonatomic, strong) NSMutableArray *buttonArray;
//添加图片按钮
@property(nonatomic, strong) UIButton *addPictureButton;
//图片数组
@property(nonatomic, strong) NSMutableArray *imageArray;
//视频大小标签
@property(nonatomic, retain) UILabel *videoSizeLable;
//视频压缩完成
@property(nonatomic, assign) BOOL isVideoCompression;
//视频展示VIew
@property(nonatomic, retain) UIImageView *showView;
//录制视频按钮
@property(nonatomic, retain) UIButton *MonthlyRepor;
//视频流数组
@property(nonatomic, retain) NSMutableArray *VideoDataArray;
//图片流数组
@property(nonatomic, retain) NSMutableArray *ImgDataArray;
//图片流类型数组
@property(nonatomic, retain) NSMutableArray *ImgTypeArray;
//视频流类型数组
@property(nonatomic, retain) NSMutableArray *VideoTypeArray;
@end
