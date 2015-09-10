//
//  XKSquareButton.m
//  百思不得姐
//
//  Created by MD313  on 15/9/7.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKSquareButton.h"
#import "XKSquare.h"
#import <UIButton+WebCache.h>
@implementation XKSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // button imageView的位置
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.y = self.height * 0.1;
    self.imageView.centerX = self.width * 0.5;
    
    // button titleLabel的位置
    self.titleLabel.width = self.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(XKSquare *)square
{
    _square = square;
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self setTitle:square.name forState:UIControlStateNormal];
}
@end
