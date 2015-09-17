//
//  XKTopicCell.h
//  百思不得姐
//
//  Created by MD313  on 15/9/14.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKTopic;

@interface XKTopicCell : UITableViewCell

/** 帖子模型 */
@property(nonatomic,strong) XKTopic *topic;

@end
