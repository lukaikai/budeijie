//
//  XKPostWordTextView.m
//  百思不得姐
//
//  Created by MD313  on 15/9/10.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKPlaceholderTextView.h"

//@interface XKPlaceholderTextView ()
//
//@property (nonatomic, weak) UILabel *placeholderL;
//
//@end
@implementation XKPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor grayColor];
        // 添加文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
        
        // 第二种方法
//        UILabel *placeholderL = [[UILabel alloc] init];
//        placeholderL.numberOfLines = 0;
//        self.placeholderL = placeholderL;
//        [self addSubview:placeholderL];
    }
    return self;
}
/**
 *  移除通知
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  文字改变重绘
 */
- (void)textDidChange:(NSNotification *)note
{
    [self setNeedsDisplay];
//    self.placeholderL.hidden = self.hasText;
    
}

/**
 *  画文字
 */
- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return; // 有文字直接返回
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    // 画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    self.placeholderL.x = 5;
//    self.placeholderL.y = 8;
//    self.placeholderL.width = self.width - 2 * self.placeholderL.x;
//    [self.placeholderL sizeToFit];
//}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}
#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
//    self.placeholderL.text = placeholder;
//    [self.placeholderL sizeToFit];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
    
//    [self.placeholderL sizeToFit];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

@end
