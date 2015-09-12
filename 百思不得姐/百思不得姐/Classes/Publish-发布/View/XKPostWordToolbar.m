//
//  XKPostWordToolbar.m
//  百思不得姐
//
//  Created by MD313  on 15/9/11.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKPostWordToolbar.h"
#import "XKAddTagViewController.h"
#import "XKNavigationController.h"
@interface XKPostWordToolbar ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation XKPostWordToolbar

- (void)awakeFromNib
{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
}

- (void)addClick
{
    XKAddTagViewController *addTagVc = [[XKAddTagViewController alloc] init];
    XKNavigationController *nav = [[XKNavigationController alloc] initWithRootViewController:addTagVc];
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    [vc presentViewController:nav animated:YES completion:nil];
}
@end
