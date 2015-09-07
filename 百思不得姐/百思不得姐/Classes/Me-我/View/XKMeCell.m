//
//  XKMeCell.m
//  百思不得姐
//
//  Created by MD313  on 15/9/7.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKMeCell.h"

@implementation XKMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    // 调整imageView
    self.imageView.x = XKCommonMargin;
    self.imageView.y = XKCommonMargin * 0.5;
    self.imageView.height = self.height - 2 * self.imageView.y;
    self.imageView.width = self.imageView.height;
    // 调整textLabel
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + XKCommonMargin;
}
@end
