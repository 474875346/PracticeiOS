//
//  MessageTableViewCell.h
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/19.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *redView;
@end
