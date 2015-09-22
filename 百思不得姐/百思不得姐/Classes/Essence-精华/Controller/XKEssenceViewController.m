//
//  XKEssenceViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/1.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//  精华首页

#import "XKEssenceViewController.h"
#import "XKTagViewController.h"
#import "XKTitleButton.h"
#import "XKAllViewController.h"
#import "XKVideoViewController.h"
#import "XKVoiceViewController.h"
#import "XKPictureViewController.h"
#import "XKWordViewController.h"

@interface XKEssenceViewController ()<UIScrollViewDelegate>

/** 这个scrollView的作用：存放所有子控制器的view */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 以前被选中的按钮 */
@property (nonatomic, weak) XKTitleButton *selectedTitleButton;
/** 标题栏底部的指示器 */
@property (nonatomic, weak) UIView *btnBottomView;
/** 存放所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *titleButtons;

@property (nonatomic, weak) UIView *titlesView;
@end

@implementation XKEssenceViewController

#pragma mark - lazy
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏
    [self setupNav];
    // 设置子控制器
    [self setupChildVcs];
    // 设置scrollView 存放所有子控制器的view
    [self setupScrollView];
    // 设置顶部标签
    [self setupTitlesView];
   
}
/**
 *  设置子控制器
 */
- (void)setupChildVcs
{
    XKAllViewController *allVc = [[XKAllViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    XKVideoViewController *videoVc = [[XKVideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    XKVoiceViewController *voiceVc = [[XKVoiceViewController alloc] init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    XKPictureViewController *pictureVc = [[XKPictureViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    XKWordViewController *wordVc = [[XKWordViewController alloc] init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
    // 顶部工具条 跟随
    for (XKTopicViewController *topicVc in self.childViewControllers) {
        topicVc.blockTitlesViewY = ^(CGFloat titlesViewY){
            [self setupTitlesViewY:titlesViewY];
        };
    }
}
/**
 *  顶部工具条 跟随
 */
- (void)setupTitlesViewY:(CGFloat)titlesViewY
{
    if (titlesViewY == XKNavBarMaxY - XKTitlesViewH + 3) {
        [UIView animateWithDuration:0.25 animations:^{
            self.titlesView.y = titlesViewY;
        }];
    }
    self.titlesView.y = titlesViewY;
}
/**
 *  设置顶部标签
 */
- (void)setupTitlesView
{
    // 标签栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    titlesView.frame = CGRectMake(0, XKNavBarMaxY, self.view.width, XKTitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    // 标签栏里的按钮
    NSUInteger count = self.childViewControllers.count;
    CGFloat titleButtonH = titlesView.height;
    CGFloat titleButtonW = titlesView.width / count;
    for (int i = 0; i < count; i++) {
        XKTitleButton *titleButton = [XKTitleButton buttonWithType:UIButtonTypeCustom];
        // 按钮文字
        [titleButton setTitle:[self.childViewControllers[i] title] forState:UIControlStateNormal];
        
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
        // 添加点击事件
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleButtons addObject:titleButton];
        [titlesView addSubview:titleButton];
    }
    
    // 标签按钮底部指示器
    UIView *btnBottomView = [[UIView alloc] init];
    btnBottomView.height = 3;
    btnBottomView.y = titlesView.height - btnBottomView.height;
    btnBottomView.backgroundColor = [self.titleButtons.lastObject titleColorForState:UIControlStateSelected];
    [titlesView addSubview:btnBottomView];
    self.btnBottomView = btnBottomView;
    
    // 默认点击第一个按钮
    XKTitleButton *firstTitleButton = self.titleButtons.firstObject;
    [firstTitleButton.titleLabel sizeToFit];
    btnBottomView.width = firstTitleButton.titleLabel.width;
    btnBottomView.centerX = firstTitleButton.centerX;
    [self titleClick:firstTitleButton];
}
/**
 *  设置scrollView 存放所有子控制器的view
 */
- (void)setupScrollView
{
    // 禁止自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    // 分页
    scrollView.pagingEnabled = YES;
    // 背景颜色
    scrollView.backgroundColor = XKCommonBgColor;
    // 滚动范围
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    // 默认选中全部
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 *  设置导航栏
 */
- (void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}
#pragma mark - 监听
/**
 *  标签栏 按钮点击
 */
- (void)titleClick:(XKTitleButton *)titleButton
{
    // 选中状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 计算底部指示器位置
    [UIView animateWithDuration:0.2 animations:^{
        self.btnBottomView.centerX = titleButton.centerX;
        self.btnBottomView.width = titleButton.titleLabel.width;
    }];
    
    // 让scrollView滚动到对应的位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = [self.titleButtons indexOfObject:titleButton] *  self.view.width;
//    self.scrollView.contentOffset = offset;
    [self.scrollView setContentOffset:offset animated:YES];
}
/**
 *  左上角 按钮点击
 */
- (void)tagClick
{
    XKTagViewController *tagVc = [[XKTagViewController alloc] init];

    [self.navigationController pushViewController:tagVc animated:YES];
}
#pragma mark - UIScrollViewDelegate
/**
 * 当滚动动画完毕的时候调用（通过代码setContentOffset:animated:让scrollView滚动完毕后，就会调用这个方法）
 * 如果执行完setContentOffset:animated:后，scrollView的偏移量并没有发生改变的话，就不会调用scrollViewDidEndScrollingAnimation:方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 取出对应的控制器
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowVc = self.childViewControllers[index];

    // 如果控制器的view已经被创建过，就直接返回
    if (willShowVc.isViewLoaded) return;
    
    // 添加子控制器的view到scrollView身上
    willShowVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowVc.view];
}
/**
 * 当减速完毕的时候调用（人为拖拽scrollView，手松开后scrollView慢慢减速完毕到静止）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 相当于点击对应位置的按钮
    int index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titleButtons[index]];
}

@end
