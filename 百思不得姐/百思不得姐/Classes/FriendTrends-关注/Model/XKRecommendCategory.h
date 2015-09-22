//
//  XKRecommendCategory.h
//  百思不得姐
//
//  Created by MD313  on 15/9/20.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XKRecommendUser;

@interface XKRecommendCategory : NSObject

/** 名字 */
@property(nonatomic, copy) NSString *name;
/** id */
@property(nonatomic, copy) NSString *ID;

/** 右边用户数据 */
@property (strong, nonatomic) NSMutableArray *users;
/** 用户数据当前页码 */
@property(nonatomic, assign) NSInteger page;
/** 类别对应的用户总数 */
@property(nonatomic, assign) NSInteger total;

@end
