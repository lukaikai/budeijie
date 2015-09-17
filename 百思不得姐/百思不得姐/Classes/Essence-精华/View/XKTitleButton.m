//
//  XKTitleButton.m
//  百思不得姐
//
//  Created by MD313  on 15/9/13.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTitleButton.h"

@implementation XKTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted { }

@end
