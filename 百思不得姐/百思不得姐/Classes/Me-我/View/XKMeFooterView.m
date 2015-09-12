//
//  XKMeFooterView.m
//  百思不得姐
//
//  Created by MD313  on 15/9/7.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKMeFooterView.h"
#import <AFNetworking.h>
#import "XKSquare.h"
#import <MJExtension.h>
#import "XKSquareButton.h"
#import "XKWebViewController.h"

@implementation XKMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 网络请求
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        XKWeakSelf;
        [[AFHTTPSessionManager manager] GET:XKRequestURL parameters:params success:^void(NSURLSessionDataTask * task, id responseObject) {
            [weakSelf createSquares:[XKSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]]];
        } failure:^void(NSURLSessionDataTask * task, NSError * error) {
            
        }];
    }
    
    return self;
}

- (void)createSquares:(NSArray *)squares
{
    // 每行的列数
    NSInteger colsCount = 4;
    
    // 按钮尺寸
    CGFloat buttonW = self.width / colsCount;
    CGFloat buttonH = buttonW;
    // 创建按钮
    for (NSInteger i = 0; i < squares.count; i++) {
        // 创建button
        XKSquareButton *button = [XKSquareButton buttonWithType:UIButtonTypeCustom];
        // 按钮frame
        CGFloat buttonX = (i / colsCount) * buttonW;
        CGFloat buttonY = (i % colsCount) * buttonH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 数据
        button.square = squares[i];
        // 点击事件
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        // 重新设置高度 不然按钮超出边界 不能点击
        self.height = CGRectGetMaxY(button.frame);
    }
    // 超出屏幕 能滚动
    UITableView *tableView = (UITableView *)self.superview;
    tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.frame));
}

- (void)btnClick:(XKSquareButton *)button
{
    if (![button.square.url hasPrefix:@"http"]) return;
    
    XKWebViewController *webVc = [[XKWebViewController alloc] init];
    webVc.square = button.square;
    UITabBarController *rootVc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootVc.selectedViewController;
    [nav pushViewController:webVc animated:YES];
}
@end
