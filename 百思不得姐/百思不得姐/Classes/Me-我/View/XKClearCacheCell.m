//
//  XKClearCacheCell.m
//  百思不得姐
//
//  Created by MD313  on 15/9/8.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKClearCacheCell.h"
#import <SVProgressHUD.h>
// 缓存路径
#define XKCacheFile [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"default"]

static NSString * const XKDefaultText = @"清除缓存";
@implementation XKClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = XKDefaultText;
        // 禁止点击
        self.userInteractionEnabled = NO;
        // 右边菊花
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.accessoryView = loadingView;
        [loadingView startAnimating];
       
        // 计算缓存大小
      [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
          CGFloat size = XKCacheFile.fileSize;
          NSInteger unit = 1000;
          NSString *text = nil;
          if (size >= unit * unit * unit) {// G
              text = [NSString stringWithFormat:@"%@(%.1fG)",XKDefaultText, size / unit / unit / unit];
          }else if(size >= unit * unit){// M
              text = [NSString stringWithFormat:@"%@(%.1fM)",XKDefaultText, size / unit / unit];
          }else if(size >= unit){// K
              text = [NSString stringWithFormat:@"%@(%.1fK)",XKDefaultText, size / unit];
          }else{// B
              text = [NSString stringWithFormat:@"%@(%.1fB)",XKDefaultText, size];
          }
          // 回到主线程
          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
              self.textLabel.text = text;
              self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
              self.accessoryView = nil;
              // 允许点击
              self.userInteractionEnabled = YES;
          }];
      }];
    }
    return self;
}
/**
 * 更新状态
 */
- (void)updateStatus
{
    if (self.accessoryView == nil) return;
    // 让菊花继续旋转
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}
/**
 * 清除缓存
 */
- (void)clearCache
{
    [SVProgressHUD showWithStatus:@"正在清除..." maskType:SVProgressHUDMaskTypeBlack];
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        // 清除缓存
        [[NSFileManager defaultManager] removeItemAtPath:XKCacheFile error:nil];
        // 回到主线程更新
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            
            self.textLabel.text = XKDefaultText;
            // 禁止点击
            self.userInteractionEnabled = NO;
        }];
    }];
}
@end
