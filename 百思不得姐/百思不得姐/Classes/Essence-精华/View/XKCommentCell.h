//
//  XKCommentCell.h
//  百思不得姐
//
//  Created by MD313  on 15/9/18.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKComment;

@interface XKCommentCell : UITableViewCell
/** 评论数据 */
@property(nonatomic,strong) XKComment *comment;
@end
