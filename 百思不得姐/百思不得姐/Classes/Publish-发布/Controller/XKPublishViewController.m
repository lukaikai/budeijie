//
//  XKPublishViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/9.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKPublishViewController.h"
#import "XKPublishButton.h"
#import <POP.h>
#import "XKPostWordViewController.h"
#import "XKNavigationController.h"

@interface XKPublishViewController ()

/** 标语 */
@property (nonatomic, weak) UIImageView *sloganView;
/** 动画时间 */
@property (nonatomic, strong) NSArray *times;
/** 按钮 */
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation XKPublishViewController

#pragma mark - lazy
- (NSArray *)times
{
    if (!_times) {
        CGFloat interval = 0.1; // 时间间隔
        _times = @[@(2 * interval),
                   @(1 * interval),
                   @(4 * interval),
                   @(3 * interval),
                   @(5 * interval),
                   @(6 * interval)];
    }
    return _times;
}
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 禁止交互
    self.view.userInteractionEnabled = NO;
    // 标语
    [self setupSlogan];
    // 按钮
    [self setupButtons];
    
}
/**
 *  标语
 */
- (void)setupSlogan
{
    // 标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.centerX = XKScreenW * 0.5;
    sloganView.y = XKScreenH * 0.15 - XKScreenH;
    self.sloganView = sloganView;
    [self.view addSubview:sloganView];
    
    // 动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(XKScreenH * 0.15);
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    XKWeakSelf;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        weakSelf.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}
/**
 *  按钮
 */
- (void)setupButtons
{
    // 按钮数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 按钮尺寸
    NSInteger count = images.count; // 按钮数量
    NSInteger maxClos = 3; // 列数
    NSInteger rowsCount = (count + maxClos - 1) / maxClos;// 行数
    CGFloat buttonW = XKScreenW / maxClos;
    CGFloat buttonH = buttonW;
    CGFloat startY = (XKScreenH - rowsCount * buttonH) * 0.5;
    
    // 创建 添加按钮
    for (int i = 0; i < count; i++) {
        
        XKPublishButton *button = [XKPublishButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.buttons addObject:button];
        // frame
        CGFloat buttonX = (i % maxClos) * buttonW;
        CGFloat buttonY = startY + (i / maxClos) * buttonH;
        button.frame = CGRectMake(buttonX, buttonY - XKScreenH, buttonW, buttonH);
        
        // 数据
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        // 动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.toValue = @(buttonY);
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        
        [button pop_addAnimation:anim forKey:nil];
        
    }
}
/**
 *  按钮点击
 */
- (void)buttonClick:(XKPublishButton *)button
{
    NSInteger index = [self.buttons indexOfObject:button];
    
    switch (index) {
        case 2:{
            [self exit:^{
                XKPostWordViewController *wordVc = [[XKPostWordViewController alloc] init];
                
                [self.view.window.rootViewController presentViewController:[[XKNavigationController alloc] initWithRootViewController:wordVc] animated:YES completion:nil];
            }];
        }
            break;
            
        default:
            break;
    }
}
/**
 *  取消
 */
- (IBAction)cancel
{
    [self exit:nil];
}
/**
 *  退出
 */
- (void)exit:(void (^)())task
{
    // 禁止交互
    self.view.userInteractionEnabled = NO;
    // 让按钮执行动画
    for (int i = 0; i < self.buttons.count; i++) {
        XKPublishButton *button = self.buttons[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.toValue = @(button.y + XKScreenH);
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // 标语动画
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.sloganView.y + XKScreenH);
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    XKWeakSelf;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
        if (task) task();
    }];
    [self.sloganView pop_addAnimation:anim forKey:nil];
}
@end
