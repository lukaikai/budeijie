//
//  XKAddTagViewController.h
//  百思不得姐
//
//  Created by MD313  on 15/9/11.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKAddTagViewController : UIViewController
/** 传递tag数据的block, block的参数是一个字符串数组 */
@property(nonatomic, copy) void (^getTagsBlock)(NSArray *);
/** 从上一个界面传递过来的标签数据 */
@property (nonatomic, strong) NSArray *tags;
@end
