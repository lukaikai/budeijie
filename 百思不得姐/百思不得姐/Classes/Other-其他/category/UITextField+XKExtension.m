//
//  UITextField+XKExtension.m
//  百思不得姐
//
//  Created by MD313  on 15/9/11.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "UITextField+XKExtension.h"

@implementation UITextField (XKExtension)

/** 占位文字颜色 */
static NSString * const XKPlaceholderColorKey = @"placeholderLabel.textColor";

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [self setValue:placeholderColor forKeyPath:XKPlaceholderColorKey];
}

- (UIColor *)placeholderColor
{
    return [self valueForKey:XKPlaceholderColorKey];
}

@end
