//
//  XKTagButton.m
//  百思不得姐
//
//  Created by MD313  on 15/9/11.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTagButton.h"

@implementation XKTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = XKColor(70, 142, 243);
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    
    self.height = XKTagH;
    self.width += 3 * XKCommonSmallMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = XKCommonSmallMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + XKCommonSmallMargin;
}
@end
