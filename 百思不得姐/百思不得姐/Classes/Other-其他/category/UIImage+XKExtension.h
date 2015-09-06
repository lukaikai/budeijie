//
//  UIImage+XKExtension.h
//  百思不得姐
//
//  Created by MD313  on 15/9/6.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XKExtension)
/**
 * 返回一张圆形图片
 */
- (instancetype)circleImage;
/**
 * 返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;

@end
