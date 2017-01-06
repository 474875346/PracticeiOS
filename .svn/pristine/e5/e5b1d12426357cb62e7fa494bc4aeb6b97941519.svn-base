//
//  ImageScrollview.m
//  FoodSafetyAssistant
//
//  Created by 新龙信息 on 16/7/28.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "ImageScrollview.h"
#import "Common.h"

@implementation ImageScrollview
#pragma mark 加载网络图片的方法
- (id)initWithFrame:(CGRect)frame
     WithImageArray:(NSArray *)imageArray
          WithIndex:(NSInteger)index {
  self = [super initWithFrame:frame];
  if (self) {
    _count = imageArray.count;
    self.backgroundColor = [UIColor blackColor];
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:frame];
    scrollview.bounces = NO;
    scrollview.pagingEnabled = YES;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.contentSize =
        CGSizeMake(imageArray.count * SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollview.delegate = self;
    [self addSubview:scrollview];
    scrollview.contentOffset = CGPointMake(SCREEN_WIDTH * (index - 1), 0);
    // Imageview
    for (int i = 0; i < imageArray.count; i++) {
      UIImageView *imageview = [[UIImageView alloc]
          initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH,
                                   SCREEN_HEIGHT)];
      imageview.contentMode = 1;
      imageview.clipsToBounds = YES;
      [imageview sd_setImageWithURL:[NSURL URLWithString:imageArray[i]]
                   placeholderImage:IMG(@"zhanwu.jpg")];
      imageview.userInteractionEnabled = YES;
      UITapGestureRecognizer *singleTap =
          [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(clickImage)];
      [imageview addGestureRecognizer:singleTap];

      [scrollview addSubview:imageview];
    }
    //序号label
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 50);
    _titleLabel.bounds = CGRectMake(0, 0, 120, 40);
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textAlignment = 1;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = [NSString stringWithFormat:@"%ld/%ld", index, _count];
    [self addSubview:_titleLabel];
  }
  return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  int x = scrollView.contentOffset.x / SCREEN_WIDTH + 1;
  _titleLabel.text = [NSString stringWithFormat:@"%d/%ld", x, _count];
}
- (void)clickImage {
  _returnBlock();
}

#pragma mark 加载本地图片的方法
- (id)initWithFrame:(CGRect)frame
    WithNativeImageArray:(NSArray *)nativeImageArray
               WithIndex:(NSInteger)index {
  self = [super initWithFrame:frame];
  if (self) {
    _count = nativeImageArray.count;
    self.backgroundColor = [UIColor blackColor];
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:frame];
    scrollview.bounces = NO;
    scrollview.pagingEnabled = YES;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.contentSize =
        CGSizeMake(nativeImageArray.count * SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollview.delegate = self;
    scrollview.contentOffset = CGPointMake(SCREEN_WIDTH * (index - 1), 0);
    NSLog(@"偏移量是 %f", scrollview.contentOffset.x);
    [self addSubview:scrollview];

    // Imageview
    for (int i = 0; i < nativeImageArray.count; i++) {
      UIImageView *imageview = [[UIImageView alloc]
          initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH,
                                   SCREEN_HEIGHT)];
      imageview.contentMode = 1;
      imageview.clipsToBounds = YES;
      imageview.image = nativeImageArray[i];
      imageview.userInteractionEnabled = YES;
      UITapGestureRecognizer *singleTap =
          [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(clickImage)];
      [imageview addGestureRecognizer:singleTap];

      [scrollview addSubview:imageview];
    }
    //序号label
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 50);
    _titleLabel.bounds = CGRectMake(0, 0, 120, 40);
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textAlignment = 1;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = [NSString stringWithFormat:@"%ld/%ld", index, _count];
    [self addSubview:_titleLabel];
  }
  return self;
}

@end
