//
//  ImageAndLabelView.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/29.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "ImageAndLabelView.h"
#import "Common.h"

@implementation ImageAndLabelView

-(id)initWithFrame:(CGRect)frame WithImage:(NSString *)image WithTitle:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.center = CGPointMake(W(self)/2, H(self)/2 - 10);
        imageView.bounds = CGRectMake(0, 0, 40, 40);
        imageView.image = IMG(image);
        [self addSubview:imageView];
        UILabel *label = [[UILabel alloc]init];
        label.center = CGPointMake(W(self)/2, H(self)/2 + 22);
        label.bounds = CGRectMake(0, 0, W(self), 20);
        label.font = [UIFont systemFontOfSize:13];
        label.text = title;
        label.textAlignment = 1;
        [self addSubview:label];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, W(self), H(self));
        button.backgroundColor = [UIColor clearColor];
        _button = button;
        [self addSubview:button];
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = COLOR(204, 204, 204, 1).CGColor;
    
    }
    return self;
}

@end
