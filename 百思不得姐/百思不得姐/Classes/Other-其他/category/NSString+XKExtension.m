//
//  NSString+XKExtension.m
//  百思不得姐
//
//  Created by MD313  on 15/9/8.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "NSString+XKExtension.h"

@implementation NSString (XKExtension)
/**
 *  文件大小
 */
- (CGFloat)fileSize
{
    // 文件管理者
    NSFileManager *mar = [NSFileManager defaultManager];
    // 是否是文件夹
    BOOL isDirectory = NO;
    // 路径是否存在
    BOOL exists = [mar fileExistsAtPath:self isDirectory:&isDirectory];
    // 路径不存在
    if (exists == NO) return 0;
    if (isDirectory) {// 文件夹
        // 总大小
        CGFloat size = 0;
        // 获得文件夹中的所有内容
        NSDirectoryEnumerator *enumerator = [mar enumeratorAtPath:self];
        for (NSString *subPath in enumerator) {
            // 全路径
            NSString *fullSubPath = [self stringByAppendingPathComponent:subPath];
            
            size += [mar attributesOfItemAtPath:fullSubPath error:nil].fileSize;
        }
        return size;
    }else{// 文件
        return [mar attributesOfItemAtPath:self error:nil].fileSize;
    }
}
/*
- (void)fileSize
{
    // 文件管理者
    NSFileManager *mar = [NSFileManager defaultManager];
    // 文件路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [caches stringByAppendingPathComponent:@"default"];
    CGFloat size = 0;
    // 获得文件夹下所有内容
    //    NSArray *subPaths = [mar subpathsAtPath:filePath];
    NSDirectoryEnumerator *enumerator = [mar enumeratorAtPath:filePath];
    for (NSString *subPath in enumerator) {
        // 获得全路径
        NSString *fullSubPath = [filePath stringByAppendingPathComponent:subPath];
        NSDictionary *attrs = [mar attributesOfItemAtPath:fullSubPath error:nil];
        size += attrs.fileSize;
    }
    XKLog(@"%.1fM",size / 1000 / 1000);
}
*/
@end
