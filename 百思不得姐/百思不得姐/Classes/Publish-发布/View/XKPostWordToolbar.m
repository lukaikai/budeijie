//
//  XKPostWordToolbar.m
//  百思不得姐
//
//  Created by MD313  on 15/9/11.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//  标签键盘工具条

#import "XKPostWordToolbar.h"
#import "XKAddTagViewController.h"
#import "XKNavigationController.h"

@interface XKPostWordToolbar ()

/** 底部view */
@property (weak, nonatomic) IBOutlet UIView *bottomView;
/** 顶部view高 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 加号按钮 */
@property (weak, nonatomic) UIButton *addButton;
/** 所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;

@end

@implementation XKPostWordToolbar

#pragma mark - lazy
- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}
- (void)awakeFromNib
{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    // 默认传递2个标签
    [self createTagLabels:@[@"吐槽",@"糗事"]];
}
// 键盘上面加号按钮
- (void)addClick
{
    XKAddTagViewController *addTagVc = [[XKAddTagViewController alloc] init];
    XKNavigationController *nav = [[XKNavigationController alloc] initWithRootViewController:addTagVc];
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    [vc presentViewController:nav animated:YES completion:nil];
    XKWeakSelf
    // 逆传 标签控制器把数据传给 键盘上的标签
    addTagVc.getTagsBlock = ^(NSArray *tags){
        [weakSelf createTagLabels:tags];
    };
    // 顺传 把默认标签 传给控制器
    addTagVc.tags = [self.tagLabels valueForKeyPath:@"text"];
}
/**
 * 创建标签label
 */
- (void)createTagLabels:(NSArray *)tags
{
    // 移除所有的lable
    // 让self.tagLabels数组中的所有对象执行removeFromSuperview方法
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < tags.count; i++) {
        // 创建label
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.text = tags[i];
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.backgroundColor = XKColor(70, 142, 243);
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.font = [UIFont systemFontOfSize:14];
        [self.topView addSubview:tagLabel];
        [self.tagLabels addObject:tagLabel];
        
        // 尺寸
        [tagLabel sizeToFit];
        tagLabel.height = XKTagH;
        tagLabel.width += 2 * XKCommonSmallMargin;
    }
    // 重新布局子控件
    [self setNeedsLayout];
}
/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.tagLabels.count; i++) {
        // 创建label
        UILabel *tagLabel = self.tagLabels[i];
        // 位置
        if (i == 0) { // 第一个标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        }else{ // 不是第一个
            UILabel *previousTagLabel = self.tagLabels[i - 1];
            CGFloat leftWidth = CGRectGetMaxX(previousTagLabel.frame) + XKCommonSmallMargin;
            CGFloat rigthWidth = self.topView.width - leftWidth;
            if (rigthWidth >= tagLabel.width) {
                tagLabel.x = leftWidth;
                tagLabel.y = previousTagLabel.y;
            }else{
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(previousTagLabel.frame);
            }
        }
    }
    
    // 加号按钮位置
    UILabel *lastTagLabel = self.tagLabels.lastObject;
    if (lastTagLabel) {
        CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + XKCommonSmallMargin;
        CGFloat rigthWidth = self.topView.width - leftWidth;
        if (rigthWidth >= self.addButton.width) {
            self.addButton.x = leftWidth;
            self.addButton.y = lastTagLabel.y;
        }else{
            self.addButton.x = 0;
            self.addButton.y = CGRectGetMaxY(lastTagLabel.frame);
        }
    }else{
        self.addButton.x = 0;
        self.addButton.y = 0;
    }
    
    // 计算工具条的高度
    self.topViewHeight.constant = CGRectGetMaxY(self.addButton.frame);
    CGFloat oldHeigth = self.height;
    self.height = self.topViewHeight.constant + self.bottomView.height + XKCommonSmallMargin;
    self.y += oldHeigth - self.height;
}
@end
