//
//  XKPostWordViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/9.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKPostWordViewController.h"
#import "XKPlaceholderTextView.h"
@interface XKPostWordViewController ()<UITextViewDelegate>

@end

@implementation XKPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"发表文字";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    // 强制更新(能马上刷新现在的状态)
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
    // 添加输入框
    [self setupTextView];
}
/*
 // 重新刷新自己和子控件的所有内容（状态、尺寸）
 [tempView layoutIfNeeded];
 // 重新调用tempView的layoutSubviews（重新排布子控件的frame）
 [tempView setNeedsLayout];
 // 重新调用tempView的drawRect:方法（重新绘制tempView里面的内容，一般不包括子控件）
 [tempView setNeedsDisplay];
 */
/**
 *  输入框
 */
- (void)setupTextView
{
    XKPlaceholderTextView *textView = [[XKPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    // 不管内容有多少，竖直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
}
- (void)post
{
    XKLogFunc;
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}
@end
