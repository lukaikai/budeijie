//
//  XKNewViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKNewViewController.h"

@interface XKNewViewController ()

@end

@implementation XKNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航栏title
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(btnClick)];
    
    // 背景颜色
    self.view.backgroundColor = XKCommonBgColor;
}

- (void)btnClick
{
    XKLog(@"%s",__func__);
}
@end
