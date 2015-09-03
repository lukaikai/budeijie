//
//  XKMeViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKMeViewController.h"
#import "XKSettingViewController.h"

@interface XKMeViewController ()

@end

@implementation XKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的";
    // 导航栏右边按钮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(btnClick1)];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    // 背景颜色
    self.view.backgroundColor = XKCommonBgColor;
}

- (void)btnClick1
{
    XKLog(@"%s",__func__);
}
- (void)settingClick
{
    XKSettingViewController *setting = [[XKSettingViewController alloc] init];
    
    [self.navigationController pushViewController:setting animated:YES];
}
@end
