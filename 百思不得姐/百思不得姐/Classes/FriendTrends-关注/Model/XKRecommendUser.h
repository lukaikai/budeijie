//
//  XKRecommendUser.h
//  百思不得姐
//
//  Created by MD313  on 15/9/20.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKRecommendUser : NSObject

/** 昵称 */
@property(nonatomic, copy) NSString *screen_name;
/** 头像 */
@property(nonatomic, copy) NSString *header;
/** 粉丝数量 */
@property(nonatomic, assign) NSInteger fans_count;

@end
