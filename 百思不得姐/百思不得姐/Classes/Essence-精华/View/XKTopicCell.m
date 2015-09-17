//
//  XKTopicCell.m
//  百思不得姐
//
//  Created by MD313  on 15/9/14.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTopicCell.h"
#import "XKTopic.h"
#import "XKTopicPictureView.h"
#import "XKTopicVoiceView.h"
#import "XKTopicVideoView.h"
@interface XKTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@property (weak, nonatomic) XKTopicPictureView *pictureView;
@property (weak, nonatomic) XKTopicVoiceView *voiceView;
@property (weak, nonatomic) XKTopicVideoView *videoView;

@end

@implementation XKTopicCell

#pragma mark - lazy
- (XKTopicVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [XKTopicVideoView viewFromNib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}
- (XKTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [XKTopicVoiceView viewFromNib];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}
- (XKTopicPictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [XKTopicPictureView viewFromNib];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}
- (void)awakeFromNib
{
    // cell的背景图片
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    // 
}
- (void)setTopic:(XKTopic *)topic
{
    _topic = topic;
    [self.profileImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;

    // 底部工具条
    [self setupBtnTitle:self.dingBtn number:topic.ding placeholder:@"顶"];
    [self setupBtnTitle:self.caiBtn number:topic.cai placeholder:@"踩"];
    [self setupBtnTitle:self.shareBtn number:topic.repost placeholder:@"分享"];
    [self setupBtnTitle:self.commentBtn number:topic.comment placeholder:@"评论"];
    
    // 中间内容
    if (topic.type == XKTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureFrame;
    }else if (topic.type == XKTopicTypeVoice){
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.frame = topic.pictureFrame;
    }else if (topic.type == XKTopicTypeVideo){
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.topic = topic;
        self.videoView.frame = topic.pictureFrame;
    }else if (topic.type == XKTopicTypeWord){
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
}
/**
 * 设置工具条按钮的文字
 */
- (void)setupBtnTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += XKCommonMargin;
    frame.size.height -= XKCommonMargin;
    [super setFrame:frame];
}
/**
 *  又上角按钮功能
 */
- (IBAction)cellMoreClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                                
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        XKLog(@"收藏");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        XKLog(@"举报");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        XKLog(@"取消");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end
