//
//  LabelAndTFView.m
//  FoodSafetyAssistant
//
//  Created by 新龙信息 on 16/7/12.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "Common.h"
#import "LabelAndTFView.h"

@implementation LabelAndTFView

- (id)initWithFrame:(CGRect)frame
     WithLabelTitleArray:(NSArray *)titleArray
    WithPlaceholderArray:(NSArray *)placeholderArray {

  self = [super initWithFrame:frame];
  if (self) {
    _TFArray = [[NSMutableArray alloc] init];
    self.clipsToBounds = YES;

    float height = frame.size.height / titleArray.count;
    float width = frame.size.width;

    for (int i = 0; i < titleArray.count; i++) {
      UILabel *label = [[UILabel alloc]
          initWithFrame:CGRectMake(0, i * height, 0.25 * width, height)];
      label.text = titleArray[i];
      label.backgroundColor = [UIColor clearColor];
      label.textColor = [UIColor blackColor];
      [self addSubview:label];

      UITextField *textfield = [[UITextField alloc]
          initWithFrame:CGRectMake(0.25 * width, i * height, 0.75 * width,
                                   height)];
      textfield.placeholder = placeholderArray[i];
      textfield.clearButtonMode = UITextFieldViewModeAlways;
      textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
      //            textfield.secureTextEntry = YES;
      textfield.backgroundColor = [UIColor clearColor];
      [self addSubview:textfield];
        //灰色间隔线
        UIView *line = [[UIView alloc]
                        initWithFrame:CGRectMake(0, (i + 1) * H(textfield)- 0.5, width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
      //加密
      NSString *string = titleArray[i];
      if ([string rangeOfString:@"密码"].length) {
        textfield.secureTextEntry = YES;
      }
      [_TFArray addObject:textfield];
    }
  }
  return self;
}
@end

@implementation ImageViewAndTF
- (id)initWithFrame:(CGRect)frame
     WithLabelImageArray:(NSArray *)imageArray
    WithPlaceholderArray:(NSArray *)placeholderArray {
  self = [super initWithFrame:frame];
  if (self) {
    _TFArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageArray.count; i++) {
      UIImageView *imageView = [[UIImageView alloc]
          initWithFrame:CGRectMake(10, 10 + 50 * i, 30, 30)];
      imageView.image = IMG(imageArray[i]);
      [self addSubview:imageView];

      UITextField *textfield = [[UITextField alloc]
          initWithFrame:CGRectMake(50, 5 + 50 * i, ScreenWidth - 85, 40)];
      textfield.placeholder = placeholderArray[i];
      textfield.borderStyle = UITextBorderStyleRoundedRect;
      textfield.backgroundColor = [UIColor clearColor];
      textfield.textAlignment = 1;
      textfield.clearButtonMode = UITextFieldViewModeAlways;
      //            textfield.secureTextEntry = YES;
      textfield.clipsToBounds = YES;
      textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
      [self addSubview:textfield];

      //加密
      NSString *string = imageArray[i];
      MyLog(@"%@ ", string);
      if ([string rangeOfString:@"password"].length) {
        textfield.secureTextEntry = YES;
      }
      [_TFArray addObject:textfield];
    }

    //灰色间隔线
    //        for (int i = 0; i < imageArray.count - 1; i ++) {
    //            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, (i +
    //            1) * 40 , SCREEN_WIDTH, 0.5)];
    //            line.backgroundColor = [UIColor lightGrayColor];
    //            [self addSubview:line];
    //        }
  }
  return self;
}
@end
