//
//  XKCommentCell.m
//  百思不得姐
//
//  Created by MD313  on 15/9/18.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKCommentCell.h"
#import "XKComment.h"
#import "XKUser.h"

@interface XKCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end
@implementation XKCommentCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.autoresizesSubviews = NO;
}
- (void)setComment:(XKComment *)comment
{
    _comment = comment;
    [self.profileImageView setHeader:comment.user.profile_image];
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = comment.like_count;
    self.contentLabel.text = comment.content;
    
    if ([comment.user.sex isEqualToString:XKUserSexMale]) {
        self.sexView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
        self.sexView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:comment.voicetime forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
}
@end
