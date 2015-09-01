//
//  XKTabBarController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTabBarController.h"
#import "XKEssenceViewController.h"
#import "XKNewViewController.h"
#import "XKFriendTrendsViewController.h"
#import "XKMeViewController.h"
#import "XKTabBar.h"
@interface XKTabBarController ()

@end

@implementation XKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加自控制器
    [self setupChildsVc];
    // 设置item属性
    [self setupItem];
    // 设置自定义tabbar
    [self setValue:[[XKTabBar alloc] init] forKeyPath:@"tabBar"];
}
/**
 *  添加自控制器
 */
- (void)setupChildsVc
{
    [self setupChildVc:[[XKEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[XKNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[XKFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[XKMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}
/**
 *  添加子控制器
 *
 *  @param vc            控制器
 *  @param title         文字
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.view.backgroundColor = [UIColor grayColor];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:nav];
}
/**
 * 设置item属性
 */
- (void)setupItem
{
    // 普通状态文字属性
    NSMutableDictionary *normalAttributes = [NSMutableDictionary dictionary];
    normalAttributes[NSForegroundColorAttributeName] = [UIColor grayColor];
    normalAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // 选中状态文字属性
    NSMutableDictionary *selectedAttributes = [NSMutableDictionary dictionary];
    selectedAttributes[NSForegroundColorAttributeName] = [UIColor grayColor];
    UITabBarItem *item = [UITabBarItem appearance];
    
    // 统一给所有的UITabBarItem设置文字属性
    [item setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
}
@end
