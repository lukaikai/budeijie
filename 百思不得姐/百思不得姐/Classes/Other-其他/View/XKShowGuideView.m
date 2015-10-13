//
//  XKShowGuideView.m
//  百思不得姐
//
//  Created by MD313  on 15/9/23.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKShowGuideView.h"

@implementation XKShowGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        // 把展示页面加到window上
        UIScrollView *guideView = [[UIScrollView alloc] initWithFrame:window.bounds];
        guideView.backgroundColor = [UIColor redColor];
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
