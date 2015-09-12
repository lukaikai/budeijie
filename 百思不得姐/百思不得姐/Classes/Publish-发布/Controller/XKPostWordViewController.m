//
//  XKPostWordViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/9.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKPostWordViewController.h"
#import "XKPlaceholderTextView.h"
#import "XKLoginRegisterViewController.h"
#import "XKPostWordToolbar.h"
@interface XKPostWordViewController ()<UITextViewDelegate>
/** 工具条 */
@property (nonatomic, weak) XKPostWordToolbar *toolbar;
/** 输入框 */
@property (nonatomic, weak) XKPlaceholderTextView *textView;

@end

@implementation XKPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏
    [self setupNav];
    
    // 添加输入框
    [self setupTextView];
    
    // 设置键盘上辅助工具条
    [self setupToolbar];
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
 *  设置键盘上辅助工具条
 */
- (void)setupToolbar
{
    XKPostWordToolbar *toolbar = [XKPostWordToolbar viewFromNib];
    toolbar.x = 0;
    toolbar.y = XKScreenH - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  设置导航栏
 */
- (void)setupNav
{
    self.title = @"发表文字";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    // 强制更新(能马上刷新现在的状态)
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
}
/**
 *  输入框
 */
- (void)setupTextView
{
    XKPlaceholderTextView *textView = [[XKPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.height = XKScreenH * 0.4;
    // 不管内容有多少，竖直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    self.textView = textView;
    [self.view addSubview:textView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];

}
#pragma mark - 监听
- (void)post
{
    XKLogFunc;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDef objectForKey:@"name"];
    NSString *userPwd = [userDef objectForKey:@"pwd"];
    XKLog(@"%@,%@",userName,userPwd);
    if (!userName || !userPwd) {
        XKLoginRegisterViewController *RegisterVc = [[XKLoginRegisterViewController alloc] init];
        [self presentViewController:RegisterVc animated:YES completion:nil];
    }
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘退出时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 工具条平移的距离 == 键盘最终的Y值 - 屏幕高度
    CGFloat ty = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y - XKScreenH;
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
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
