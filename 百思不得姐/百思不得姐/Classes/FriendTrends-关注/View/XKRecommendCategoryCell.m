//
//  XKRecommendCategoryCell.m
//  百思不得姐
//
//  Created by MD313  on 15/9/20.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKRecommendCategoryCell.h"
#import "XKRecommendCategory.h"

@interface XKRecommendCategoryCell ()
/** 左边指示器 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end
@implementation XKRecommendCategoryCell

- (void)awakeFromNib {
    // 清除文字背景色 这样就挡不住分割线了
    self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor darkGrayColor];
    self.selectedIndicator.hidden = !selected;
}

- (void)setCategory:(XKRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}
@end
