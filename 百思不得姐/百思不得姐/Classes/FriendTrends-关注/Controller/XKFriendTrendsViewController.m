//
//  XKFriendTrendsViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKFriendTrendsViewController.h"

@interface XKFriendTrendsViewController ()

@end

@implementation XKFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的关注";
    // 导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(btnClick)];
}

- (void)btnClick
{
    XKLog(@"%s",__func__);
}
@end
