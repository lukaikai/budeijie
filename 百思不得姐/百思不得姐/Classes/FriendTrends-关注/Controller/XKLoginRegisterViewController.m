//
//  XKLoginRegisterViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/3.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKLoginRegisterViewController.h"

@interface XKLoginRegisterViewController ()

@end

@implementation XKLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  关闭
 */
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// iOS7之前修改状态栏样式
// [UIApplication sharedApplication].statusBarStyle;
// iOS7开始由控制器来修改状态栏样式
/**
 * 让状态栏样式为白色
 */

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
