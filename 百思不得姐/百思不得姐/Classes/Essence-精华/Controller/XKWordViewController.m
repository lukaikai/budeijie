//
//  XKWordViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/13.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKWordViewController.h"

@interface XKWordViewController ()

@end

@implementation XKWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = XKCommonBgColor;
    // 内容inset
    self.tableView.contentInset = UIEdgeInsetsMake(XKNavBarMaxY + XKTitlesViewH, 0, XKUITabBarH, 0);
    // 右边滚动条inset
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}
 
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd -- ", self.title, indexPath.row];
    
    return cell;
}
@end
