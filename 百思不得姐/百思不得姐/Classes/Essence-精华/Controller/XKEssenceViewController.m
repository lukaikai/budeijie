//
//  XKEssenceViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKEssenceViewController.h"
#import "XKTagViewController.h"

@interface XKEssenceViewController ()

@end

@implementation XKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void)tagClick
{
    XKTagViewController *tagVc = [[XKTagViewController alloc] init];
    tagVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagVc animated:YES];
}
@end
