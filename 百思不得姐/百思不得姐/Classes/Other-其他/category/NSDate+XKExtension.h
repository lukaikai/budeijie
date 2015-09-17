//
//  NSDate+XKExtension.h
//  百思不得姐
//
//  Created by MD313  on 15/9/15.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XKExtension)

- (NSDateComponents *)intervalToDate:(NSDate *)date;
- (NSDateComponents *)intervalToNow;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

/**
 * 是否为明天
 */
- (BOOL)isTomorrow;
@end
