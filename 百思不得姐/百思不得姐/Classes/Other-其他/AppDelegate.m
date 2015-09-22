//
//  AppDelegate.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "AppDelegate.h"
#import "XKTabBarController.h"
@interface AppDelegate ()

@property (strong, nonatomic) UIWindow *topWindow;

@end

@implementation AppDelegate

#pragma mark - lazy
- (UIWindow *)topWindow
{
    if (!_topWindow) {
        _topWindow = [[UIWindow alloc] init];
        _topWindow.frame = CGRectMake(0, 0, XKScreenW, 20);
        _topWindow.windowLevel = UIWindowLevelAlert;
        [_topWindow addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
        _topWindow.hidden = NO;
    }
    return _topWindow;
}
- (void)topWindowClick
{
    // 取出所有的window
    NSArray *windows = [UIApplication sharedApplication].windows;
    // 遍历程序中所有的控件
    for (UIWindow *window in windows) {
        [self searchSubviews:window];
    }
}
/**
 *  搜索superview内的所有子控件
 */
- (void)searchSubviews:(UIView *)superview
{
    for (UIScrollView *scrollView in superview.subviews) {
        // 递归
        [self searchSubviews:scrollView];
        // 判断是否是scrollView
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        // 计算出scrollView在window坐标系上的矩形框
        CGRect scrollViewRect = [scrollView convertRect:scrollView.bounds toView:scrollView.window];
        CGRect windowRect = scrollView.window.bounds;
        // 判断scrollView的边框是否和window的边框交叉
        if (!CGRectIntersectsRect(scrollViewRect, windowRect)) continue;
        
        // 让scrollView滚到最前面
        CGPoint offset = scrollView.contentOffset;
        // 偏移量不一定是0
        offset.y = -scrollView.contentInset.top;
        
        [scrollView setContentOffset:offset animated:YES];
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOption
{
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置窗口根控制器
    self.window.rootViewController = [[XKTabBarController alloc] init];
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
/**
 *  程序激活调用一次
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self topWindow];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
