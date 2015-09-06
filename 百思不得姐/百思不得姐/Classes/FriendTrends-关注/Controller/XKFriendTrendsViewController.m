//
//  XKFriendTrendsViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//  关注首页

#import "XKFriendTrendsViewController.h"
#import "XKLoginRegisterViewController.h"

@interface XKFriendTrendsViewController ()

@end

@implementation XKFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的关注";
    
    // 导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommendClick)];
    
    // 背景颜色
    self.view.backgroundColor = XKCommonBgColor;
}

- (void)friendsRecommendClick
{
    UITableViewController *TableViewC = [[UITableViewController alloc] init];
    [self.navigationController pushViewController:TableViewC animated:YES];
    
}
/**
 *  立即登录
 */
- (IBAction)loginRegister
{
    XKLoginRegisterViewController *loginRegister = [[XKLoginRegisterViewController alloc] init];
   
    [self presentViewController:loginRegister animated:YES completion:nil];
    
}
@end
