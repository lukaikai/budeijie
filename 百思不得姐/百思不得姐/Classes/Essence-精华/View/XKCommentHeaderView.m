//
//  XKCommentHeaderView.m
//  百思不得姐
//
//  Created by MD313  on 15/9/18.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKCommentHeaderView.h"

@interface XKCommentHeaderView ()
/** 内部的label */
@property (nonatomic, weak) UILabel *label;

@end
@implementation XKCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = XKCommonBgColor;
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.x = XKCommonSmallMargin;
        self.label = label;
        [self.contentView addSubview:label];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    self.label.text = text;
}
@end
