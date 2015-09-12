//
//  XKAddTagViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/11.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKAddTagViewController.h"
#import "XKTagButton.h"
#import "XKTagTextField.h"

@interface XKAddTagViewController ()<UITextFieldDelegate>
/** 用来容纳所有按钮和文本框 */
@property (nonatomic, weak) UIView *contentView;
/** 提醒按钮 */
@property (nonatomic, weak) UIButton *tipButton;
/** 文本框 */
@property (nonatomic, weak) UITextField *textF;
/** 存放所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation XKAddTagViewController

#pragma mark - 懒加载

- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
- (UIButton *)tipButton
{
    if (!_tipButton) {
        _tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _tipButton.width = self.contentView.width;
        _tipButton.height = XKTagH;
        _tipButton.backgroundColor = [UIColor orangeColor];
        _tipButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _tipButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _tipButton.contentEdgeInsets = UIEdgeInsetsMake(0, XKCommonSmallMargin, 0, 0);
        [_tipButton addTarget:self action:@selector(tipClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_tipButton];
    }
    return _tipButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextField];
}

- (void)setupNav
{
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)setupContentView
{
    UIView *contenView = [[UIView alloc] init];
    contenView.x = XKCommonSmallMargin;
    contenView.y = XKNavBarMaxY + XKCommonSmallMargin;
    contenView.width = XKScreenW - 2 * contenView.x;
    contenView.height = XKScreenH;
    self.contentView = contenView;
    [self.view addSubview:contenView];
}
- (void)setupTextField
{
    XKTagTextField *textF = [[XKTagTextField alloc] init];
    // frame
    textF.width = self.contentView.width;
    textF.height = XKTagH;
    // 设置占位文字
    textF.placeholder = @"多个标签用逗号或者换行隔开";
    textF.placeholderColor = [UIColor grayColor];
    
    [self.contentView addSubview:textF];
    
    [textF becomeFirstResponder];
    [textF layoutIfNeeded];
    // 文字改变的监听
    [textF addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    textF.delegate = self;
    self.textF = textF;
    XKWeakSelf;
    textF.deleteBackwardOperation = ^{
        // 文本框有文字 直接返回 删除文字
        if (weakSelf.textF.hasText) return;
        
        [weakSelf tagClick:self.tagButtons.lastObject];
    };
}
#pragma mark - 监听
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)done
{
    
}
- (void)textDidChange
{
    if (self.textF.hasText) {
        NSString *text = self.textF.text;
        NSString *lastChar = [text substringFromIndex:text.length - 1];
        if ([lastChar isEqualToString:@","] || [lastChar isEqualToString:@"，"]) { // 是逗号
             // 去掉文本框最后一个逗号
//            self.textF.text = [text substringToIndex:text.length - 1];
            [self.textF deleteBackward];
            [self tipClick];
        }else{ // 不是逗号 排布文本框
//            CGFloat textW = [text sizeWithAttributes:@{NSFontAttributeName : self.textF.font}].width;
//            // 最后一个标签按钮
//            XKTagButton *lastTagButton = self.tagButtons.lastObject;
//            // 左边的总宽度
//            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + XKCommonSmallMargin;
//            // 右边剩余宽度
//            CGFloat rigthWidth = self.contentView.width - leftWidth;
//            if (rigthWidth >= textW) { // 同一行
//                self.textF.x = leftWidth;
//                self.textF.y = lastTagButton.y;
//            }else{ //  不同行
//                self.textF.x = 0;
//                self.textF.y = CGRectGetMaxY(lastTagButton.frame) + XKCommonSmallMargin;
//            }
            [self setupTextFieldFrame];
        }
        self.tipButton.hidden = NO;
        [self.tipButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textF.text] forState:UIControlStateNormal];
//        self.tipButton.y = CGRectGetMaxY(self.textF.frame) + XKCommonSmallMargin;
    }else{
        self.tipButton.hidden = YES;
    }
}
- (void)tipClick
{
    if (!self.textF.hasText) return;
    // 创建标签按钮
    XKTagButton *newTagButton = [XKTagButton buttonWithType:UIButtonTypeCustom];

    [newTagButton setTitle:self.textF.text forState:UIControlStateNormal];
    [newTagButton addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:newTagButton];
    
    // 标签按钮位置
    // 最后一个标签按钮
//    XKTagButton *lastTagButton = self.tagButtons.lastObject;
//    if (lastTagButton) { // 不是第一个按钮
//        // 左边的总宽度
//        CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + XKCommonSmallMargin;
//        // 右边剩余宽度
//        CGFloat rigthWidth = self.contentView.width - leftWidth;
//        if (rigthWidth >= newTagButton.width) { // 同一行
//            newTagButton.x = leftWidth;
//            newTagButton.y = lastTagButton.y;
//        }else{ // 下一行
//            newTagButton.x = 0;
//            newTagButton.y = CGRectGetMaxY(lastTagButton.frame) + XKCommonSmallMargin;
//        }
//    }else{ // 第一个按钮
//        newTagButton.x = 0;
//        newTagButton.y = 0;
//    }
    // 标签按钮位置
    [self setupTagButtonFrame:newTagButton referenceTagButton:self.tagButtons.lastObject];
    
    [self.tagButtons addObject:newTagButton];
    
    // 文本框位置
    // 左边的总宽度
//    CGFloat leftWidth = CGRectGetMaxX(newTagButton.frame) + XKCommonSmallMargin;
//    CGFloat rigthWidth = self.contentView.width - leftWidth;
//    if (rigthWidth >= 100) { // 同一行
//        self.textF.x = leftWidth;
//        self.textF.y = newTagButton.y;
//    }else{ // 下一行
//        self.textF.x = 0;
//        self.textF.y = CGRectGetMaxY(newTagButton.frame) + XKCommonSmallMargin;
//    }
    // 文本框位置
    [self setupTextFieldFrame];
    // 清除文本框 内容
    self.textF.text = nil;
    // 隐藏提醒按钮
    self.tipButton.hidden = YES;
}
/**
 * 点击了标签按钮
 */
- (void)tagClick:(XKTagButton *)clickedTagButton
{
    // 要删除按钮的索引
    NSUInteger index = [self.tagButtons indexOfObject:clickedTagButton];
    // 删除按钮
    [clickedTagButton removeFromSuperview];
    [self.tagButtons removeObject:clickedTagButton];
    // 重新排布后面的按钮
    for (NSUInteger i = index; i < self.tagButtons.count; i++) {
        XKTagButton *tagButton = self.tagButtons[i];
        // 如果i不为0，就参照上一个标签按钮
        XKTagButton *previousTagButton = (i == 0) ? nil : self.tagButtons[i - 1];
        // 排布按钮
        [self setupTagButtonFrame:tagButton referenceTagButton:previousTagButton];
    }
    // 重新排布文本框
    [self setupTextFieldFrame];
}
#pragma mark - 设置控件的frame
/**
 * 设置标签按钮的frame
 * @param tagButton 需要设置frame的标签按钮
 * @param referenceTagButton 计算tagButton的frame时参照的标签按钮
 */
- (void)setupTagButtonFrame:(XKTagButton *)tagButton referenceTagButton:(XKTagButton *)referenceTagButton
{
    if (referenceTagButton) { // 不是第一个按钮
        // 左边的总宽度
        CGFloat leftWidth = CGRectGetMaxX(referenceTagButton.frame) + XKCommonSmallMargin;
        // 右边剩余宽度
        CGFloat rigthWidth = self.contentView.width - leftWidth;
        if (rigthWidth >= tagButton.width) { // 同一行
            tagButton.x = leftWidth;
            tagButton.y = referenceTagButton.y;
        }else{ // 下一行
            tagButton.x = 0;
            tagButton.y = CGRectGetMaxY(referenceTagButton.frame) + XKCommonSmallMargin;
        }
    }else{ // 第一个按钮
        tagButton.x = 0;
        tagButton.y = 0;
    }
}
/**
 *  文本框frame
 */
- (void)setupTextFieldFrame
{
    CGFloat textW = [self.textF.text sizeWithAttributes:@{NSFontAttributeName : self.textF.font}].width;
    textW = MAX(textW, 100);
    // 最后一个标签按钮
    XKTagButton *lastTagButton = self.tagButtons.lastObject;
    // 左边的总宽度
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + XKCommonSmallMargin;
    // 右边剩余宽度
    CGFloat rigthWidth = self.contentView.width - leftWidth;
    if (rigthWidth >= textW) { // 同一行
        self.textF.x = leftWidth;
        self.textF.y = lastTagButton.y;
    }else{ //  不同行
        self.textF.x = 0;
        self.textF.y = CGRectGetMaxY(lastTagButton.frame) + XKCommonSmallMargin;
    }
    // 排布提醒按钮
    self.tipButton.y = CGRectGetMaxY(self.textF.frame) + XKCommonSmallMargin;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self tipClick];
    return YES;
}
@end
