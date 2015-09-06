//
//  XKTagCell.m
//  百思不得姐
//
//  Created by MD313  on 15/9/6.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//  精华推荐标签cell

#import "XKTagCell.h"
#import "XKTag.h"

@interface XKTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation XKTagCell

/**
 * 重写这个方法的目的：拦截cell的frame设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}
/**
 *  设置数据
 */
- (void)setTagModel:(XKTag *)tagModel
{
    _tagModel = tagModel;
    
    self.themeNameLabel.text = tagModel.theme_name;
    
    [self.imageListView setHeader:tagModel.image_list];
    
    if (tagModel.sub_number >= 10000) {// 大于一万人
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",tagModel.sub_number / 10000.0];
    }else{// 不大于一万人
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅",tagModel.sub_number];
    }
}

@end
