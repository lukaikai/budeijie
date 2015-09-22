//
//  XKTopicViewController.h
//  百思不得姐
//
//  Created by MD313  on 15/9/20.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKTopic.h"

@interface XKTopicViewController : UITableViewController
- (XKTopicType)topicType;
/** block */
@property(nonatomic, copy) void (^blockTitlesViewY)(CGFloat);

@end
