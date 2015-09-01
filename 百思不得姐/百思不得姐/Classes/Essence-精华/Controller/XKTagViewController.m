//
//  XKTagViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTagViewController.h"

@interface XKTagViewController ()

@end

@implementation XKTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"推荐标签";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
