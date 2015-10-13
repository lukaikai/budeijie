//
//  XKViewForFooterSection.m
//  百思不得姐
//
//  Created by MD313  on 15/10/9.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKViewForFooterSection.h"

@interface XKViewForFooterSection ()

@property (nonatomic, strong) NSMutableArray *buttons;

@end
@implementation XKViewForFooterSection

#pragma mark - lazy
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    NSArray *buttonTitles = @[@"帖子",@"关注",@"粉丝",@"消息通知"];
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

- (void)createButtons
{
    NSArray *buttonTitles = @[@"帖子",@"关注",@"粉丝",@"消息通知"];
    NSInteger count = buttonTitles.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    CGFloat buttonY = 0;
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.frame = CGRectMake(i * buttonW, buttonY, buttonW, buttonH);
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    NSArray *buttonTitles = @[@"帖子",@"关注",@"粉丝",@"消息通知"];
    NSInteger count = buttonTitles.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    CGFloat buttonY = 0;
    XKLog(@"%f",self.width);
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.frame = CGRectMake(i * buttonW, buttonY, buttonW, buttonH);
    }
}
- (void)btnClick
{
    XKLogFunc;
}
@end
