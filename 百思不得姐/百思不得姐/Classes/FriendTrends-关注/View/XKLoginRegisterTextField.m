//
//  XKLoginRegisterTextField.m
//  百思不得姐
//
//  Created by MD313  on 15/9/3.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKLoginRegisterTextField.h"

// 占位文字颜色Key
#define XKPlaceholderColorKey @"placeholderLabel.textColor"
// 默认的占位文字颜色
#define XKPlaceholderDefaultColor [UIColor grayColor]
// 聚焦的占位文字颜色
#define XKPlaceholderFocusColor [UIColor whiteColor]

//@interface XKLoginRegisterTextField ()<UITextFieldDelegate>
//
//@end
@implementation XKLoginRegisterTextField

- (void)awakeFromNib
{
    // 光标颜色
    self.tintColor = XKPlaceholderFocusColor;
    
    // 文字颜色
    self.textColor = XKPlaceholderFocusColor;
    
    // 占位文字颜色 (最终)
    [self resignFirstResponder];
    
    // 占位文字颜色（第一种方法）
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
    
    // 占位文字颜色（第三种方法）
    
//    [self setValue:XKPlaceholderDefaultColor forKeyPath:XKPlaceholderColorKey];
    
    // 通过addTarget:-》监听文本框的开始和结束编辑
//    [self addTarget:self action:@selector(beginEditing) forControlEvents:UIControlEventEditingDidBegin];
//    [self addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventEditingDidEnd];
    
    // 这种做法不推荐，因为delegate属性很容易被外界覆盖
    // self.delegate = self;
    
    // 通过通知-》监听文本框的开始和结束编辑
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing) name:UITextFieldTextDidEndEditingNotification object:self];
}

// 编辑状态下placeholderLabel文字颜色 最终方案
- (BOOL)becomeFirstResponder
{
    [self setValue:XKPlaceholderFocusColor forKeyPath:XKPlaceholderColorKey];
    return [super becomeFirstResponder];
}
- (BOOL)resignFirstResponder
{
    [self setValue:XKPlaceholderDefaultColor forKeyPath:XKPlaceholderColorKey];
    return [super resignFirstResponder];
}
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
// 编辑状态下placeholderLabel文字颜色
//- (void)beginEditing
//{
//    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
//}
//- (void)endEditing
//{
//    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
//}
// 编辑状态下placeholderLabel文字颜色
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
//}




// 占位文字颜色 第二种方法
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    rect.origin.y = (self.height - self.font.lineHeight) * 0.5;
//    
//    // 文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    attrs[NSFontAttributeName] = self.font;
//    [self.placeholder drawInRect:rect withAttributes:attrs];
//    
//    // 占位文字画在哪个位置
//    //    CGPoint point;
//    //    point.x = 0;
//    //    point.y = (self.height - self.font.lineHeight) * 0.5;
//    //
//    //    // 文字属性
//    //    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    //    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
//    //    attrs[NSFontAttributeName] = self.font;
//    //    [self.placeholder drawAtPoint:point withAttributes:attrs];
//}


@end
