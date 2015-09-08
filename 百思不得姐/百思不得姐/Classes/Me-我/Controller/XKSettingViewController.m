//
//  XKSettingViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKSettingViewController.h"
#import "XKClearCacheCell.h"

@interface XKSettingViewController ()

@end

@implementation XKSettingViewController

static NSString * const clearCellID = @"clear";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
 
    // 背景颜色
    self.view.backgroundColor = XKCommonBgColor;
    // 注册
    [self.tableView registerClass:[XKClearCacheCell class] forCellReuseIdentifier:clearCellID];
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:clearCellID];
    [cell updateStatus];
    return cell;
}

#pragma mark - 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 清除缓存
    XKClearCacheCell *cell = (XKClearCacheCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell clearCache];
}
@end
