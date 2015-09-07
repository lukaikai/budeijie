//
//  XKMeViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKMeViewController.h"
#import "XKSettingViewController.h"
#import "XKMeCell.h"
#import "XKMeFooterView.h"
@interface XKMeViewController ()

@end

@implementation XKMeViewController

static NSString * const XKMeCellID = @"meCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航控制器
    [self setupNav];
    // 设置内容
    [self setupTable];
}
/**
 *  设置内容
 */
- (void)setupTable
{
    // 注册
    [self.tableView registerClass:[XKMeCell class] forCellReuseIdentifier:XKMeCellID];
    // cell头部间距
    self.tableView.sectionHeaderHeight = 0;
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    self.tableView.tableFooterView = [[XKMeFooterView alloc] init];
}
/**
 *  设置导航控制器
 */
- (void)setupNav
{
    self.navigationItem.title = @"我的";
    // 导航栏右边按钮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    // 背景颜色
    self.view.backgroundColor = XKCommonBgColor;
}
- (void)moonClick
{
    XKLog(@"%s",__func__);
}
- (void)settingClick
{
    XKSettingViewController *setting = [[XKSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKMeCell *cell = [tableView dequeueReusableCellWithIdentifier:XKMeCellID];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
    }else{
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}
@end
