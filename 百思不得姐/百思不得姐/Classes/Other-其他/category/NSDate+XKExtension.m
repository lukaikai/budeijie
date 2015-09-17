//
//  NSDate+XKExtension.m
//  百思不得姐
//
//  Created by MD313  on 15/9/15.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "NSDate+XKExtension.h"

@implementation NSDate (XKExtension)

- (NSDateComponents *)intervalToDate:(NSDate *)date
{
    // 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 需要比较的元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 比较
    return [calendar components:unit fromDate:self toDate:date options:0];
}

- (NSDateComponents *)intervalToNow
{
    return [self intervalToDate:[NSDate date]];
}

/**
 * 是否为今年
 */
- (BOOL)isThisYear
{
    // 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得年
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

/**
 * 是否为今天
 */
- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfSting = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfSting];
}

/**
 * 是否为昨天
 */
- (BOOL)isYesterday
{
    // 格式化
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfSting = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfSting];
    
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
}

/**
 * 是否为明天
 */
- (BOOL)isTomorrow
{
    // 格式化
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfSting = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfSting];
    
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0 && comps.month == 0 && comps.day == -1;
}
@end
