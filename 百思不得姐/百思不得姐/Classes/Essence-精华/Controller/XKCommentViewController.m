//
//  XKCommentViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/18.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKCommentViewController.h"
#import "XKTopicCell.h"
#import "XKTopic.h"
#import "XKCommentCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "XKComment.h"
#import "XKCommentHeaderView.h"
@interface XKCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 所有评论 */
@property (strong, nonatomic) NSMutableArray *comments;
/** 最热评论 */
@property (strong, nonatomic) NSArray *hotComments;
/** 网络请求管理者 */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** 暂存最热评论 */
@property (strong, nonatomic) XKComment *topComment;
/** 上一页“评论”中的最后一个评论的id */
@property (copy, nonatomic) NSString *lastcid;
@end

@implementation XKCommentViewController

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
    
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setupTable];
    
    [self setupRefresh];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 恢复最热评论数据
    if (self.topComment) {
        self.topic.topComment = self.topComment;
        self.topic.topicCellH = 0;
    }
}
/**
 *  设置table
 */
static NSString * const XKCommentCellID = @"CommentCell";
static NSString * const XKCommentHeaderId = @"CommentHeader";
- (void)setupTable
{
    self.tableView.backgroundColor = XKCommonBgColor;
    // 处理数据
    if (self.topic.topComment) {
        self.topComment = self.topic.topComment;
        self.topic.topComment = nil;
        self.topic.topicCellH = 0;
    }
    // 头部
    XKTopicCell *cell = [XKTopicCell viewFromNib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, XKScreenW, self.topic.topicCellH);
    
    UIView *view = [[UIView alloc] init];
    view.height = cell.height + 2 * XKCommonMargin;
    [view addSubview:cell];
    
    self.tableView.tableHeaderView = view;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XKCommentCell class]) bundle:nil] forCellReuseIdentifier:XKCommentCellID];
    [self.tableView registerClass:[XKCommentHeaderView class] forHeaderFooterViewReuseIdentifier:XKCommentHeaderId];
    
    // 自动计算cell的高度
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

- (void)loadNewComments
{
    // 取消之前的请求任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    // 请求数据
    XKWeakSelf
    [self.manager GET:XKRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 最热评论
        weakSelf.hotComments = [XKComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        // 全部评论
        weakSelf.comments = [XKComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        [self.tableView.header endRefreshing];
    }];
}

- (void)loadMoreComments
{
    // 取消之前的请求任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    // 请求数据
    XKWeakSelf
    [self.manager GET:XKRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 最热评论
        weakSelf.hotComments = [XKComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        // 全部评论
        weakSelf.comments = [XKComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        [self.tableView.header endRefreshing];
    }];
}
#pragma mark - 监听
- (void)keyboardChangeFrame:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.bottomSpace.constant = XKScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) return 2;
    if (self.comments.count) return 1;
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.hotComments.count) {
        return self.hotComments.count;
    }
    return self.comments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:XKCommentCellID];
    // 获得对应的评论
    NSArray *comments = self.comments;
    if (indexPath.section == 0 && self.hotComments.count) {
        comments = self.hotComments;
    }
    
    cell.comment = self.comments[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0 && self.hotComments.count) {
//        return @"最热评论";
//    }else{
//        return @"最新评论";
//    }
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *label = [[UILabel alloc] init];
//    if (section == 0 && self.hotComments.count) {
//        label.text = @"最热评论";
//    }else{
//        label.text = @"最新评论";
//    }
//    label.font = [UIFont systemFontOfSize:14];
//    [label sizeToFit];
//    label.x = XKCommonSmallMargin;
//    
//    UIView *header = [[UIView alloc] init];
//    header.backgroundColor = self.tableView.backgroundColor;
//    [header addSubview:label];
//    
//    return header;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XKCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:XKCommentHeaderId];
    if (section == 0 && self.hotComments.count) {
        header.text = @"最热评论";
    }else{
        header.text = @"最新评论";
    }
    return header;
}
@end
