//
//  MonthlyReporViewController.m
//  PracticeiOS
//
//  Created by 新龙科技 on 2016/12/14.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "MonthlyReporViewController.h"
#import "ImageScrollview.h"

@interface MonthlyReporViewController () {
  KZVideoModel *_videoModel;
}
@end

@implementation MonthlyReporViewController
- (NSMutableArray *)imageArray {
  if (_imageArray == nil) {
    _imageArray = [[NSMutableArray alloc] init];
  }
  return _imageArray;
}
- (UIImageView *)showView {
  if (_showView == nil) {
    _showView = [[UIImageView alloc]
        initWithFrame:CGRectMake(XW(_MonthlyRepor) + 20,
                                 YH(_MonthlyReportContent) + 20,
                                 0.25 * SCREEN_WIDTH, 0.25 * SCREEN_WIDTH)];
    [_myScrollview addSubview:_showView];
  }
  return _showView;
}
- (NSMutableArray *)VideoDataArray {
  if (_VideoDataArray == nil) {
    _VideoDataArray = [[NSMutableArray alloc] init];
  }
  return _VideoDataArray;
}
- (NSMutableArray *)ImgDataArray {
  if (_ImgDataArray == nil) {
    _ImgDataArray = [[NSMutableArray alloc] init];
  }
  return _ImgDataArray;
}
- (NSMutableArray *)ImgTypeArray {
  if (_ImgTypeArray == nil) {
    _ImgTypeArray = [[NSMutableArray alloc] init];
  }
  return _ImgTypeArray;
}
- (NSMutableArray *)VideoTypeArray {
  if (_VideoTypeArray == nil) {
    _VideoTypeArray = [[NSMutableArray alloc] init];
  }
  return _VideoTypeArray;
}
- (NSMutableArray *)buttonArray {
  if (_buttonArray == nil) {
    _buttonArray = [[NSMutableArray alloc] init];
  }
  return _buttonArray;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self.showView layoutIfNeeded];
  [self addNavigationHeadBackImage];
  [self addBackButton];
  [self addtitleWithString:@"月报"];
  [self CreatUI];
}
- (void)back {
  [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 布局
- (void)CreatUI {
  //滑动视图
  _myScrollview = [[UIScrollView alloc]
      initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 104)];
  _myScrollview.bounces = NO;
  [self.view addSubview:_myScrollview];
  //工作计划
  UILabel *planLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
  planLabel.text = @"工作计划:";
  [_myScrollview addSubview:planLabel];
  _plan = [[UITextView alloc]
      initWithFrame:CGRectMake(XW(planLabel), 10,
                               ScreenWidth - XW(planLabel) - 10, 100)];
  _plan.delegate = self;
  [_myScrollview addSubview:_plan];
  _PlanplaceHolderLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(0, 0, W(_plan), 30)];
  _PlanplaceHolderLabel.text = @"请填写您的工作计划";
  _PlanplaceHolderLabel.font = [UIFont systemFontOfSize:18];
  _PlanplaceHolderLabel.textColor = [UIColor lightGrayColor];
  [_plan addSubview:_PlanplaceHolderLabel];
  UILabel *planline = [[UILabel alloc]
      initWithFrame:CGRectMake(0, YH(_plan) + 5, ScreenWidth, 1)];
  planline.backgroundColor = [UIColor lightGrayColor];
  [_myScrollview addSubview:planline];
  //工作总结
  UILabel *summaryLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(10, YH(_plan) + 10, 80, 30)];
  summaryLabel.text = @"工作总结:";
  [_myScrollview addSubview:summaryLabel];
  _summary = [[UITextView alloc]
      initWithFrame:CGRectMake(XW(summaryLabel), YH(_plan) + 10,
                               ScreenWidth - XW(summaryLabel) - 10, 100)];
  _summary.delegate = self;
  [_myScrollview addSubview:_summary];
  _SummaryplaceHolderLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(0, 0, W(_summary), 30)];
  _SummaryplaceHolderLabel.text = @"请填写您的工作总结";
  _SummaryplaceHolderLabel.font = [UIFont systemFontOfSize:18];
  _SummaryplaceHolderLabel.textColor = [UIColor lightGrayColor];
  [_summary addSubview:_SummaryplaceHolderLabel];
  UILabel *summaryline = [[UILabel alloc]
      initWithFrame:CGRectMake(0, YH(_summary) + 5, ScreenWidth, 1)];
  summaryline.backgroundColor = [UIColor lightGrayColor];
  [_myScrollview addSubview:summaryline];
  //备注
  _MonthlyReportContent = [[UITextView alloc]
      initWithFrame:CGRectMake(20, YH(_summary) + 10, ScreenWidth - 40,
                               ScreenHeight / 4)];
  _MonthlyReportContent.delegate = self;
  [_myScrollview addSubview:_MonthlyReportContent];
  _placeHolderLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(0, 2, W(_MonthlyReportContent),
                                                H(_MonthlyReportContent))];
  _placeHolderLabel.text = @"备注";
  _placeHolderLabel.font = [UIFont systemFontOfSize:18];
  _placeHolderLabel.textColor = [UIColor lightGrayColor];
  [_MonthlyReportContent addSubview:_placeHolderLabel];
  UILabel *MonthlyReportline = [[UILabel alloc]
      initWithFrame:CGRectMake(0, YH(_MonthlyReportContent) + 5, ScreenWidth,
                               1)];
  MonthlyReportline.backgroundColor = [UIColor lightGrayColor];
  [_myScrollview addSubview:MonthlyReportline];
  //录制视频按钮
  _MonthlyRepor = [UIButton buttonWithType:UIButtonTypeCustom];
  _MonthlyRepor.frame = CGRectMake(20, YH(_MonthlyReportContent) + 20,
                                   0.25 * SCREEN_WIDTH, 0.25 * SCREEN_WIDTH);
  _MonthlyRepor.backgroundColor = kColor(29, 138, 245);
  [_MonthlyRepor setTitle:@"录制视频" forState:UIControlStateNormal];
  [_MonthlyRepor setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
  [_MonthlyRepor addTarget:self
                    action:@selector(MonthlyReporVideo:)
          forControlEvents:UIControlEventTouchUpInside];
  ViewBorderRadius(_MonthlyRepor, 0.25 * SCREEN_WIDTH / 2, 0,
                   [UIColor clearColor]);
  [_myScrollview addSubview:_MonthlyRepor];
  //视频大小标签
  _videoSizeLable = [[UILabel alloc]
      initWithFrame:CGRectMake(XW(_showView) + 20,
                               YH(_MonthlyReportContent) + 20,
                               ScreenWidth - XW(self.showView) - 40,
                               0.25 * SCREEN_WIDTH)];
  _videoSizeLable.textAlignment = NSTextAlignmentCenter;
  _videoSizeLable.numberOfLines = 0;
  [_myScrollview addSubview:_videoSizeLable];

  //添加照片和清除照片
  float picSpace = SCREEN_WIDTH * 0.25 / 6;

  UIButton *addPictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
  addPictureButton.frame = CGRectMake(picSpace, YH(_videoSizeLable) + 20,
                                      0.15 * SCREEN_WIDTH, 0.15 * SCREEN_WIDTH);
  [addPictureButton setBackgroundImage:IMG(@"addPic")
                              forState:UIControlStateNormal];
  [addPictureButton addTarget:self
                       action:@selector(addPic:)
             forControlEvents:UIControlEventTouchUpInside];
  [_myScrollview addSubview:addPictureButton];

  UIButton *deletePictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
  deletePictureButton.frame =
      CGRectMake(picSpace * 2 + 0.15 * SCREEN_WIDTH, YH(_videoSizeLable) + 20,
                 0.15 * SCREEN_WIDTH, 0.15 * SCREEN_WIDTH);
  [deletePictureButton setBackgroundImage:IMG(@"deletePic")
                                 forState:UIControlStateNormal];
  [deletePictureButton addTarget:self
                          action:@selector(delete:)
                forControlEvents:UIControlEventTouchUpInside];
  [_myScrollview addSubview:deletePictureButton];
  for (int i = 0; i < 5; i++) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(picSpace + (0.15 * SCREEN_WIDTH + picSpace) * i,
                              YH(addPictureButton) + 10, 0.15 * SCREEN_WIDTH,
                              0.15 * SCREEN_WIDTH);
    button.backgroundColor = [UIColor clearColor];
    button.tag = i;
    button.hidden = YES;
    [button addTarget:self
                  action:@selector(showImage:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.buttonArray addObject:button];
    [_myScrollview addSubview:button];
  }
  _myScrollview.contentSize = CGSizeMake(
      SCREEN_WIDTH, YH(deletePictureButton) + 20 + 0.15 * SCREEN_WIDTH);

  //提交按钮
  _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _submitButton.frame = CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);
  _submitButton.backgroundColor = COLOR(74, 176, 253, 1);
  [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
  [_submitButton setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
  [_submitButton addTarget:self
                    action:@selector(submit)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_submitButton];
}
#pragma makr 录制视频
- (void)MonthlyReporVideo:(UIButton *)btn {
  [self.VideoDataArray removeAllObjects];
  [self.VideoTypeArray removeAllObjects];
  self.showView = nil;
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:@"提示"
                       message:@"请选择视频方式？"
                preferredStyle:UIAlertControllerStyleActionSheet];
  UIAlertAction *otherAction =
      [UIAlertAction actionWithTitle:@"取消"
                               style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action){
                             }];
  [alertController addAction:otherAction];
  UIAlertAction *Video = [UIAlertAction
      actionWithTitle:@"录制视频"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *action) {
                KZVideoViewController *videoVC =
                    [[KZVideoViewController alloc] init];
                videoVC.savePhotoAlbum = YES;
                videoVC.delegate = self;
                [videoVC startAnimationWithType:KZVideoViewShowTypeSingle];
              }];
  [alertController addAction:Video];
  UIAlertAction *VideoPhoto = [UIAlertAction
      actionWithTitle:@"选择视频"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *action) {
                TZImagePickerController *imagePickerVC =
                    [[TZImagePickerController alloc]
                        initWithMaxImagesCount:9
                                      delegate:self];
                imagePickerVC.maxImagesCount = 5;
                [imagePickerVC setDidFinishPickingVideoHandle:^(UIImage *img,
                                                                id asset) {
                  self.showView.image = img;
                  PHAsset *phAsset = asset;
                  if (phAsset.mediaType == PHAssetMediaTypeVideo) {
                    PHVideoRequestOptions *options =
                        [[PHVideoRequestOptions alloc] init];
                    options.version = PHImageRequestOptionsVersionCurrent;
                    options.deliveryMode =
                        PHVideoRequestOptionsDeliveryModeAutomatic;

                    PHImageManager *manager = [PHImageManager defaultManager];
                    [manager
                        requestAVAssetForVideo:phAsset
                                       options:options
                                 resultHandler:^(AVAsset *_Nullable asset,
                                                 AVAudioMix *_Nullable audioMix,
                                                 NSDictionary *_Nullable info) {
                                   AVURLAsset *urlAsset = (AVURLAsset *)asset;

                                   NSURL *url = urlAsset.URL;
                                   [self
                                       compressedVideoOtherMethodWithURL:url
                                                         compressionType:@"AVAs"
                                                                         @"set"
                                                                         @"Exp"
                                                                         @"ort"
                                                                         @"Pre"
                                                                         @"set"
                                                                         @"Low"
                                                                         @"Qua"
                                                                         @"lit"
                                                                         @"y"];

                                 }];
                  }
                }];
                [self presentViewController:imagePickerVC
                                   animated:YES
                                 completion:nil];
              }];

  [alertController addAction:VideoPhoto];
  [self presentViewController:alertController animated:YES completion:nil];
}
- (void) delete:(UIButton *)btn {
  [_imageArray removeAllObjects];
  [_ImgDataArray removeAllObjects];
  [_ImgTypeArray removeAllObjects];
  [_buttonArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx,
                                             BOOL *_Nonnull stop) {
    UIButton *button = obj;
    [button setBackgroundImage:[UIImage imageNamed:@""]
                      forState:UIControlStateNormal];
    button.hidden = YES;
  }];
}

#pragma mark 点击放大图片
- (void)showImage:(UIButton *)button {
  NSLog(@"点击图片了");
  ImageScrollview *imageScrollview = [[ImageScrollview alloc]
             initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
      WithNativeImageArray:_imageArray
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

#pragma mark 选择图片
- (void)addPic:(UIButton *)btn {
  //选图片
  __block MonthlyReporViewController *weakself = self;
  _imagePickerVC =
      [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
  _imagePickerVC.maxImagesCount = 5;

  [_imagePickerVC setDidFinishPickingPhotosHandle:^(
                      NSArray<UIImage *> *photos, NSArray *assets,
                      BOOL isSelectOriginalPhoto) {
    for (UIImage *image in photos) {
      if (_imageArray.count < 5) {
        [weakself.imageArray addObject:image];
        NSData *imgdata = UIImageJPEGRepresentation(image, 0.5);
        [weakself.ImgDataArray addObject:imgdata];
        [weakself.ImgTypeArray addObject:@"jpg"];
      }
    }

    for (int i = 0; i < _imageArray.count; i++) {
      UIButton *button = weakself.buttonArray[i];
      [button setBackgroundImage:weakself.imageArray[i]
                        forState:UIControlStateNormal];
      button.hidden = NO;
    }
  }];
  [self presentViewController:_imagePickerVC animated:YES completion:nil];
}

#pragma mark 提交
- (void)submit {
  if (_VideoDataArray.count > 0) {
    if (_isVideoCompression == NO) {
      KOMG(@"视频还没压缩完成");
      return;
    }
  }
  NSMutableArray *DataArray = [[NSMutableArray alloc] init];
  [DataArray addObjectsFromArray:_ImgDataArray];
  [DataArray addObjectsFromArray:_VideoDataArray];
  NSMutableArray *mimeTypeArray = [[NSMutableArray alloc] init];
  [mimeTypeArray addObjectsFromArray:_ImgTypeArray];
  [mimeTypeArray addObjectsFromArray:_VideoTypeArray];
  [[HttpTool sharedInstance] upLoadToUrlString:student_reported
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID,
        @"summary" : _summary.text,
        @"plan" : _plan.text,
        @"descn" : _MonthlyReportContent.text
      }
      fileData:DataArray
      mimeType:mimeTypeArray
      progress:^(NSProgress *progress) {
      }
      success:^(NSURLSessionDataTask *dataTask, id json) {
        if ([json[@"status"] intValue] == 200) {
          KOMG(@"月报提交成功");
          [self dismissViewControllerAnimated:YES completion:nil];
        } else {
          KOMG(json[@"msg"]);
        }
      }
      failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        KOMG(kHttpError);
      }];
}
#pragma mark 条件判断
- (BOOL)conditional {
  if ([_plan.text isEqualToString:@""]) {
    KOMG(@"工作计划不能为空");
    return NO;
  }
  if ([_summary.text isEqualToString:@""]) {
    KOMG(@"工作总结不能为空");
    return NO;
  }
  if ([_MonthlyReportContent.text isEqualToString:@""]) {
    KOMG(@"月报不能为空");
    return NO;
  }
  if (_plan.text.length > 100) {
    KOMG(@"工作计划内容过长");
    return NO;
  }
  if (_summary.text.length > 100) {
    KOMG(@"工作总结内容过长");
    return NO;
  }
  if (_MonthlyReportContent.text.length > 200) {
    KOMG(@"月报内容过长");
    return NO;
  }
  return YES;
}
#pragma mark - 视频录制完成
- (void)videoViewController:(KZVideoViewController *)videoController
             didRecordVideo:(KZVideoModel *)videoModel {
  _videoModel = videoModel;

  //  NSError *error = nil;
  //  NSFileManager *fm = [NSFileManager defaultManager];
  //  NSDictionary *attri =
  //      [fm attributesOfItemAtPath:_videoModel.videoAbsolutePath
  //      error:&error];
  //  if (error) {
  //    NSLog(@"error:%@", error);
  //  } else {
  //    self.videoSizeLable.text =@"";
  //  }

  for (UIView *subview in self.showView.subviews) {
    [subview removeFromSuperview];
  }

  NSURL *videoUrl = [NSURL fileURLWithPath:_videoModel.videoAbsolutePath];
  [self compressedVideoOtherMethodWithURL:videoUrl
                          compressionType:@"AVAssetExportPresetLowQuality"];
  KZVideoPlayer *player =
      [[KZVideoPlayer alloc] initWithFrame:self.showView.bounds
                                  videoUrl:videoUrl];
  [self.showView addSubview:player];
}

- (void)videoViewControllerDidCancel:(KZVideoViewController *)videoController {
  NSLog(@"没有录到视频");
}
- (void)compressedVideoOtherMethodWithURL:(NSURL *)url
                          compressionType:(NSString *)compressionType {
  NSString *resultPath;
  NSData *data = [NSData dataWithContentsOfURL:url];
  CGFloat totalSize = (float)data.length / 1024 / 1024;
  NSLog(@"视频总大小:%.2fMB", totalSize);
  AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
  NSArray *compatiblePresets =
      [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
  // 所支持的压缩格式中是否有 所选的压缩格式
  if ([compatiblePresets containsObject:compressionType]) {
    AVAssetExportSession *exportSession =
        [[AVAssetExportSession alloc] initWithAsset:avAsset
                                         presetName:compressionType];
    NSDateFormatter *formater = [[NSDateFormatter alloc]
        init]; //用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isExists = [manager fileExistsAtPath:CompressionVideoPaht];
    if (!isExists) {
      [manager createDirectoryAtPath:CompressionVideoPaht
          withIntermediateDirectories:YES
                           attributes:nil
                                error:nil];
    }
    resultPath = [CompressionVideoPaht
        stringByAppendingPathComponent:
            [NSString
                stringWithFormat:@"outputJFVideo-%@.mov",
                                 [formater stringFromDate:[NSDate date]]]];
    NSLog(@"压缩文件路径 resultPath = %@", resultPath);
    exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse = YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void) {
      if (exportSession.status == AVAssetExportSessionStatusCompleted) {
        NSData *data = [NSData dataWithContentsOfFile:resultPath];
        float memorySize = (float)data.length / 1024 / 1024;
        NSLog(@"视频压缩后大小 %.2fMB", memorySize);
        _isVideoCompression = YES;
        [self.VideoDataArray addObject:data];
        [self.VideoTypeArray addObject:@"mp4"];
      } else {
        NSLog(@"压缩失败");
      }
    }];
  } else {
    NSLog(@"不支持 %@ 格式的压缩", compressionType);
  }
}
#pragma mark placeHolder显示隐藏
- (BOOL)textView:(UITextView *)textView
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString *)text {
  if (![text isEqualToString:@""]) {
    if ([textView isEqual:_MonthlyReportContent]) {
      _placeHolderLabel.hidden = YES;
    } else if ([textView isEqual:_plan]) {
      _PlanplaceHolderLabel.hidden = YES;
    } else {
      _SummaryplaceHolderLabel.hidden = YES;
    }
  }
  if ([text isEqualToString:@""] && range.length == 1 && range.location == 0) {
    if ([textView isEqual:_MonthlyReportContent]) {
      _placeHolderLabel.hidden = NO;
    } else if ([textView isEqual:_plan]) {
      _PlanplaceHolderLabel.hidden = NO;
    } else {
      _SummaryplaceHolderLabel.hidden = NO;
    }
  }
  return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
  if (![textView.text isEqualToString:@""]) {
    if ([textView isEqual:_MonthlyReportContent]) {
      _placeHolderLabel.hidden = YES;
    } else if ([textView isEqual:_plan]) {
      _PlanplaceHolderLabel.hidden = YES;
    } else {
      _SummaryplaceHolderLabel.hidden = YES;
    }
  }
}
@end
