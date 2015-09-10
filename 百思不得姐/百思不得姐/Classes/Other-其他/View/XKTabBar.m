//
//  XKTabBar.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTabBar.h"
#import "XKPublishViewController.h"
@interface XKTabBar ()

@property (nonatomic, weak)UIButton *publishButton;

@end
@implementation XKTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton sizeToFit];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    
    return self;
}
/**
 *  发帖子
 */
- (void)publishClick
{
    XKPublishViewController *publishVc = [[XKPublishViewController alloc] init];
    [self.window.rootViewController presentViewController:publishVc animated:NO completion:nil];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置发布按钮位置
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    // 按钮索引
    int index = 0;
    // 按钮尺寸
    CGFloat tabBarButtonY = 0;
    CGFloat tabBarButtonW = self.frame.size.width / 5;
    CGFloat tabBarButtonH = self.frame.size.height;
    // 设置4个TabBarButton的frame
    for (UIView *tabBarButton in self.subviews) {
        
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        // 计算X
        CGFloat tabBarButtonX = index * tabBarButtonW;
        
        if (index >= 2) {// 给后面2个button增加一个宽度的X值
            tabBarButtonX += tabBarButtonW;
        }
        // 设置tabBarButton的frame
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        // 增加索引
        index++;
    }
}

@end
