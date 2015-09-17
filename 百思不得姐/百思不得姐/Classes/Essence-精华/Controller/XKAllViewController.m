//
//  XKAllViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/13.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKAllViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "XKTopic.h"
#import "XKTopicCell.h"

@interface XKAllViewController ()

/** 网络请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 所有帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 加载下一页需要的参数 */
@property (nonatomic, copy) NSString *maxtime;

@end

@implementation XKAllViewController

static NSString * const XKTopicCellID = @"topic";

#pragma mark - lazy
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    // 网络请求
    [self setupRefresh];
}
- (void)setupTable
{
    self.tableView.backgroundColor = XKCommonBgColor;
    // 内容inset
    self.tableView.contentInset = UIEdgeInsetsMake(XKNavBarMaxY + XKTitlesViewH, 0, XKUITabBarH, 0);
    // 右边滚动条inset
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XKTopicCell class]) bundle:nil] forCellReuseIdentifier:XKTopicCellID];
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
/**
 *  刷新
 */
- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 上拉刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}
/**
 *  加载最新的
 */
- (void)loadNewTopics
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @1;
    XKWeakSelf
    [self.manager GET:XKRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 记录下次请求的参数
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        weakSelf.topics = [XKTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [weakSelf.tableView reloadData];
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
}
/**
 *  加载后边的
 */
- (void)loadMoreTopics
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @1;
    XKWeakSelf
    [self.manager GET:XKRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 记录下次请求的参数
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *moreTopics = [XKTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 把新数据 放到后面
        [weakSelf.topics addObjectsFromArray:moreTopics];
        // 刷新表格
        [weakSelf.tableView reloadData];
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XKTopicCellID];
    // 数据
    XKTopic *topic = self.topics[indexPath.row];
    cell.topic = topic;
    return cell;
}
#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKTopic *topic = self.topics[indexPath.row];
    return topic.topicCellH;
}
@end
