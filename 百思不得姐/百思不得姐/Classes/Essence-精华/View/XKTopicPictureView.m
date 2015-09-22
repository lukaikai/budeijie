//
//  XKTopicPictureView.m
//  百思不得姐
//
//  Created by MD313  on 15/9/16.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "XKTopic.h"
#import <DALabeledCircularProgressView.h>
#import "XKSeeBigPictureViewController.h"
@interface XKTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureBtn;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end
@implementation XKTopicPictureView

- (void)awakeFromNib
{
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.roundedCorners = 5;
    
    self.imageView.userInteractionEnabled = YES;
    // 添加点击事件  查看大图
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];

}
// 查看大图
- (void)seeBigPicture
{
    if (self.imageView.image == nil) return;
    
    XKSeeBigPictureViewController *seeBigP = [[XKSeeBigPictureViewController alloc] init];
    
    seeBigP.topic = self.topic;
    
    [self.window.rootViewController presentViewController:seeBigP animated:YES completion:nil];
}
- (void)setTopic:(XKTopic *)topic
{
    _topic = topic;
    XKWeakSelf
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 进度条
        weakSelf.progressView.hidden = NO;
        weakSelf.progressView.progress = 1.0 * receivedSize / expectedSize;
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",weakSelf.progressView.progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        weakSelf.progressView.hidden = YES;
        
        // 如果不是大图片 不需要处理
        if (!topic.isBigPicture) return;
        // 开启图文上下层
        UIGraphicsBeginImageContextWithOptions(topic.pictureFrame.size, YES, 0);
        // 画图片
        CGFloat width = topic.pictureFrame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        // 获得图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
        
        self.imageView.image = image;
    }];
    
    self.gifView.hidden = !topic.is_gif;
    
    self.seeBigPictureBtn.hidden = !topic.isBigPicture;

    if (topic.isBigPicture) {
//        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
//        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
