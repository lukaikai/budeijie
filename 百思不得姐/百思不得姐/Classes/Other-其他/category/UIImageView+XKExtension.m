//
//  UIImageView+XKExtension.m
//  百思不得姐
//
//  Created by MD313  on 15/9/6.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "UIImageView+XKExtension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (XKExtension)
/**
 * 设置头像
 */
- (void)setHeader:(NSString *)url
{
    [self setCircleHeader:url];
//    [self setRectHeader:url];
}
/**
 *  圆形头像
 */
- (void)setCircleHeader:(NSString *)url
{
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 如果图片下载失败，就不做任何处理，按照默认的做法：会显示占位图片
        if (image == nil) return;
        
        self.image = [image circleImage];
        
    }];
}
/**
 *  方形头像
 */
- (void)setRectHeader:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
