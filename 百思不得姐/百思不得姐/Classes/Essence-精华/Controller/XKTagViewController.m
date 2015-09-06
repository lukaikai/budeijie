//
//  XKTagViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//  精华标签

#import "XKTagViewController.h"
#import "XKTagCell.h"
#import <AFNetworking.h>
#import "XKTag.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface XKTagViewController ()

/** 所有标签数据 */
@property (nonatomic, strong) NSArray *tags;
/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@end
// 重用标识
static NSString * const XKTagCellID = @"tag";

@implementation XKTagViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"推荐标签";
    
    [self setupTable];
    // 数据请求
    [self loadTags];
}

- (void)loadTags
{
    [SVProgressHUD show];
    // 数据请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    // 弱引用
    XKWeakSelf
    [self.manager GET:XKRequestURL parameters:params success:^void(NSURLSessionDataTask * task, id responseObject) {
        
        if (responseObject == nil) {
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
            return;
        }
        
        weakSelf.tags = [XKTag objectArrayWithKeyValuesArray:responseObject];
        
        [weakSelf.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^void(NSURLSessionDataTask * task, NSError * error) {
        // 如果是取消了任务，就不算请求失败，就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        if (error.code == NSURLErrorTimedOut) {// 请求超时
            [SVProgressHUD showErrorWithStatus:@"加载标签数据超时，请稍后再试！"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
        }
    }];
}
- (void)dealloc
{
    // 停止请求
    [self.manager invalidateSessionCancelingTasks:YES];
    //    [self.manager.downloadTasks makeObjectsPerformSelector:@selector(cancel)];
    //    [self.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    //    [self.manager.uploadTasks makeObjectsPerformSelector:@selector(cancel)];
    
    //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //    for (NSURLSessionTask *task in self.manager.tasks) {
    //        [task cancel];
    //    }
    [SVProgressHUD dismiss];
}
- (void)setupTable
{
    // 背景颜色
    self.view.backgroundColor = XKCommonBgColor;
    
    // 每个cell的高度
    self.tableView.rowHeight = 70;
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XKTagCell class]) bundle:nil] forCellReuseIdentifier:XKTagCellID];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKTagCell *cell = [tableView dequeueReusableCellWithIdentifier:XKTagCellID];
    // 设置数据
    XKTag *tag = self.tags[indexPath.row];
    cell.tagModel = tag;
    
    return cell;
}
@end
