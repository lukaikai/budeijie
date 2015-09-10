//
//  XKPublishButton.m
//  百思不得姐
//
//  Created by MD313  on 15/9/9.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKPublishButton.h"

@implementation XKPublishButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = self.height * 0.1;

    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;

}

@end
