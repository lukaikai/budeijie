//
//  XKSettingViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//  设置

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
