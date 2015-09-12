//
//  XKTagTextField.h
//  百思不得姐
//
//  Created by MD313  on 15/9/12.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKTagTextField : UITextField
/** 点击删除键需要执行的操作 */
@property(nonatomic, copy) void (^deleteBackwardOperation)();

@end
