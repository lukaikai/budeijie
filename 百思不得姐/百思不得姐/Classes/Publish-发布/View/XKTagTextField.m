//
//  XKTagTextField.m
//  百思不得姐
//
//  Created by MD313  on 15/9/12.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTagTextField.h"

@implementation XKTagTextField
/**
 * 监听键盘内部的删除键点击
 */
- (void)deleteBackward
{
    !self.deleteBackwardOperation ? : self.deleteBackwardOperation();
    
    [super deleteBackward];
}

@end
