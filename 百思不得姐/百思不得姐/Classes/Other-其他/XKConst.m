//
//  XKConst.m
//  百思不得姐
//
//  Created by MD313  on 15/9/6.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//  定义所有的全局常量

#import <UIKit/UIKit.h>
/** 请求路径 */
NSString * const XKRequestURL = @"http://api.budejie.com/api/api_open.php";
/** 统一的间距 */
CGFloat const XKCommonMargin = 10;

/** 统一较小的间距 */
CGFloat const XKCommonSmallMargin = 5;

/** 导航栏最大的Y值 */
CGFloat const XKNavBarMaxY = 64;

/** 标签的高度 */
CGFloat const XKTagH = 25;

/** 精华titlesView的高度 */
CGFloat const XKTitlesViewH = 35;

/** UITabBar的高度 */
CGFloat const XKUITabBarH = 49;

/** 帖子-文字的Y值 */
CGFloat const XKTopicTextY = 55;

/** 帖子-底部工具条的高度 */
CGFloat const XKTopicToolbarH = 35;
/** 帖子-最热评论顶部高度 */
CGFloat const XKTopicTopCmtTopH = 18;

/** 性别男 */
NSString * const XKUserSexMale = @"m";
/** 性别女 */
NSString * const XKUserSexFemale = @"f";

/** tabBar被选中的通知名字 */
NSString * const XKTabBarDidSelectNotification = @"XKTabBarDidSelectNotification";
/**
 全局常量的写法
 1.仅限于本文件访问
 在本文件（.m）中写下面的代码
 static 类型 const 常量名 = 常量值;
 
 2.全世界都要访问
 1> 在XMGConst.m文件中
 #import <UIKit/UIKit.h>
 类型 const 常量名 = 常量值;
 
 2> 在XMGConst.h文件中
 #import <UIKit/UIKit.h>
 UIKIT_EXTERN 类型 const 常量名;
 
 3> 在pch中包含XMGConst.h文件
 #import "XMGConst.h"
 */