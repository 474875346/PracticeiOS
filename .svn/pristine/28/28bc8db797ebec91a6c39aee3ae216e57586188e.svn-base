//
//  ImageScrollview.h
//  FoodSafetyAssistant
//
//  Created by 新龙信息 on 16/7/28.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollview : UIView <UIScrollViewDelegate>
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, assign) NSInteger count;
@property(nonatomic, copy) void (^returnBlock)();
- (id)initWithFrame:(CGRect)frame
     WithImageArray:(NSArray *)imageArray
          WithIndex:(NSInteger)index;//加载网络图片

- (id)initWithFrame:(CGRect)frame
WithNativeImageArray:(NSArray *)nativeImageArray
          WithIndex:(NSInteger)index;//加载本地图片
@end
