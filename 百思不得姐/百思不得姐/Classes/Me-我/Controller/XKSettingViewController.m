//
//  XKSettingViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKSettingViewController.h"

@interface XKSettingViewController ()

@end

@implementation XKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
 
    // 背景颜色
    self.view.backgroundColor = XKCommonBgColor;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kk"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kk"];
    cell.textLabel.text = @"ddd";
    return cell;
}
@end
