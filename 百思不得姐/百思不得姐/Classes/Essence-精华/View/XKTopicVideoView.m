//
//  XKTopicVideoView.m
//  百思不得姐
//
//  Created by MD313  on 15/9/17.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTopicVideoView.h"
#import <UIImageView+WebCache.h>
#import "XKTopic.h"


@interface XKTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playerBtn;


@property (strong, nonatomic) AVPlayerItem *playerItem;

@end
@implementation XKTopicVideoView

#pragma mark - lazy
//- (AVPlayer *)player
//{
//    if (!_player) {
//        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.topic.videouri]];
//        self.playerItem = playerItem;
//        _player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
//    }
//    return _player;
//}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(XKTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    self.player = topic.player;
}

- (IBAction)playVideoBtn:(UIButton *)sender
{
    sender.hidden = YES;
    
//    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.topic.videouri]];
//    self.playerItem = playerItem;
//    _player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(0, 0, self.imageView.width, self.imageView.height);
    [self.imageView.layer addSublayer:layer];
    
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
}

- (void)videoPlayDidEnd:(NSNotification *)note
{
    self.playerBtn.hidden = NO;
    [self.player replaceCurrentItemWithPlayerItem:nil];
}
@end
