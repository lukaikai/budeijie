//
//  XKAllViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/13.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTopicViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "XKTopic.h"
#import "XKTopicCell.h"
#import "XKCommentViewController.h"
#import "XKNewViewController.h"
@interface XKTopicViewController ()

/** 网络请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 所有帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 加载下一页需要的参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 保存拖动时contentOffset的y */
@property (nonatomic, assign) CGFloat scrollStartOffsetY;

/** 上次选中的索引(或者控制器) */
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@end

@implementation XKTopicViewController
// 消除警告
- (XKTopicType)topicType
{
    return 0;
}
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
    // 初始化高scrollStartOffsetY
    self.scrollStartOffsetY = - (XKNavBarMaxY + XKTitlesViewH);
    [self setupTable];
    // 网络请求
    [self setupRefresh];
    // 监听tabbar点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelect) name:XKTabBarDidSelectNotification object:nil];
}
- (void)tabBarSelect
{
    // 如果是连续选中 并且是在当前控制器(view显示在眼前) 直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.header beginRefreshing];
    }
    // 记录这次的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}
- (void)dealloc
{
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:XKTabBarDidSelectNotification object:nil];
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
 *  新帖控制器newlist参数 精华list参数
 */
- (NSString *)aParam
{
    if ([self.parentViewController isKindOfClass:[XKNewViewController class]]) {
        return @"newlist";
    }
    return @"list";
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
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.topicType);
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
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @(self.topicType);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKCommentViewController *commentVc = [[XKCommentViewController alloc] init];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = self.scrollStartOffsetY - scrollView.contentOffset.y;

    if (offsetY >= XKNavBarMaxY) {
        offsetY = XKNavBarMaxY;
    }else if (offsetY == 0){
        offsetY = XKNavBarMaxY;
        }else if (offsetY < XKNavBarMaxY - XKTitlesViewH + 3){
            offsetY = XKNavBarMaxY - XKTitlesViewH + 3;
        }
    !self.blockTitlesViewY ? : self.blockTitlesViewY(offsetY);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.scrollStartOffsetY = scrollView.contentOffset.y;
}
@end
