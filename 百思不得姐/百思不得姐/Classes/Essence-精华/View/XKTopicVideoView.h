//
//  XKTopicVideoView.h
//  百思不得姐
//
//  Created by MD313  on 15/9/17.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKTopic;
#import <AVFoundation/AVFoundation.h>
@interface XKTopicVideoView : UIView

/** 帖子模型 */
@property(nonatomic,strong) XKTopic *topic;

@property (strong, nonatomic) AVPlayer *player;
@end
