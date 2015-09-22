//
//  XKRecommendFollowViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/20.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKRecommendFollowViewController.h"
#import "XKRecommendCategoryCell.h"
#import "XKRecommendUserCell.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "XKRecommendCategory.h"
#import "XKRecommendUser.h"

@interface XKRecommendFollowViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 左边类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边用户数据表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 左边类别数据 */
@property (strong, nonatomic) NSArray *categories;

/** 请求管理者 */
@property (weak, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation XKRecommendFollowViewController

#pragma mark - lazy
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

static NSString * const categoryCellID = @"category";
static NSString * const userCellID = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";

    self.view.backgroundColor = XKCommonBgColor;
    
    [self setupTable];
    
    [self loadCategories];
    
    [self setupRefresh];
}

- (void)setupTable
{
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XKRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryCellID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XKRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userCellID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = UIEdgeInsetsMake(XKNavBarMaxY, 0, 0, 0);
    self.categoryTableView.contentInset = inset;
    self.categoryTableView.scrollIndicatorInsets = inset;
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.userTableView.contentInset = inset;
    self.userTableView.scrollIndicatorInsets = inset;
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userTableView.rowHeight = 70;
}
/**
 *  上、下拉刷新
 */
- (void)setupRefresh
{
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}
// 结束所有请求
- (void)dealloc
{
    [self.manager invalidateSessionCancelingTasks:YES];
}
#pragma mark - 加载数据
- (void)loadCategories
{
    [SVProgressHUD show];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    // 发送请求
    XKWeakSelf
    [self.manager GET:XKRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 字典转模型
        weakSelf.categories = [XKRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [weakSelf.categoryTableView reloadData];
        
        // 默认选中左边第一行
        [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        // 让右边表格进入刷新
        [weakSelf.userTableView.header beginRefreshing];
        // 隐藏指示器
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        [SVProgressHUD dismiss];
    }];
}
- (void)loadNewUsers
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    // 取出模型
    XKRecommendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    params[@"category_id"] = category.ID;
    // 发送请求
    XKWeakSelf
    [self.manager GET:XKRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 结束刷新
        [self.userTableView.header endRefreshing];
        // 重置页码为1
        category.page = 1;
        // 字典转模型
        category.users = [XKRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 记录用户总数
        category.total = [responseObject[@"total"] integerValue];
        // 刷新表格
        [weakSelf.userTableView reloadData];
        // 判断footer是否该显示
        if (category.users.count >= category.total) {
            weakSelf.userTableView.footer.hidden = YES;
        }
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        [SVProgressHUD dismiss];
        [self.userTableView.header endRefreshing];
    }];
}

- (void)loadMoreUsers
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    // 取出模型
    XKRecommendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    params[@"category_id"] = category.ID;
    NSInteger page = category.page + 1;
    params[@"page"] = @(page);
    // 发送请求
    XKWeakSelf
    [self.manager GET:XKRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.userTableView.footer endRefreshing];
        // 记录当前页
        category.page = page;
        // 字典转模型
        NSArray *newUsers = [XKRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:newUsers];
        // 刷新表格
        [weakSelf.userTableView reloadData];
    
        // 判断footer是否该显示
        if (category.users.count >= category.total) {
            weakSelf.userTableView.footer.hidden = YES;
        }else{
            [weakSelf.userTableView.footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        [weakSelf.userTableView.footer endRefreshing];
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else{
        NSIndexPath *path = self.categoryTableView.indexPathForSelectedRow;
        XKRecommendCategory *category = self.categories[path.row];
        return category.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边类别
        XKRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellID];
        // 数据
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{ // 右边用户
        XKRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellID];
        // 数据
        XKRecommendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = category.users[indexPath.row];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边类别
        
        [self.userTableView reloadData];
        
        // 判断footer是否该显示
        XKRecommendCategory *category = self.categories[indexPath.row];
        if (category.users.count >= category.total) {
            self.userTableView.footer.hidden = YES;
        }
        // 判断是否加载过数据
        if (category.users.count == 0) { // 没加载过,才去加载
            [self.userTableView.header beginRefreshing];
        }
    }else{ // 右边用户
        
    }
}
@end
