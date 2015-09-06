//
//  UIImage+XKExtension.m
//  百思不得姐
//
//  Created by MD313  on 15/9/6.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "UIImage+XKExtension.h"
#
@implementation UIImage (XKExtension)

- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 获得上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 添加一个圆
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 把图片画到圆上
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[UIImage imageNamed:name] circleImage];
}
@end
