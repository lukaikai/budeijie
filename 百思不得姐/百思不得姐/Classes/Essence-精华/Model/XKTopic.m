//
//  XKTopic.m
//  百思不得姐
//
//  Created by MD313  on 15/9/14.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKTopic.h"

@implementation XKTopic

- (NSString *)created_at
{
    // 日期格式化
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // NSString -> NSDate
    NSDate *createdAt = [fmt dateFromString:_created_at];
    // 距离现在的时间
    NSDateComponents *cmps = [createdAt intervalToNow];
    
    if (createdAt.isThisYear) { // 今年
        if (createdAt.isToday) { // 今天
            if (cmps.hour >= 1) { // 大于1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){ // 1小时以内
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{ // 小于1分钟
                return @"刚刚";
            }
        }else if (createdAt.isYesterday){ // 昨天
            fmt.dateFormat= @"HH:mm:ss";
            return [NSString stringWithFormat:@"昨天 %@",[fmt stringFromDate:createdAt]];
        }else{// 非昨天
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAt];
        }
    }else{ // 非今年
        return _created_at;
    }
}

- (CGFloat)topicCellH
{
    if (_topicCellH == 0){
        // 文字的宽
        CGFloat textW = XKScreenW - 2 * XKCommonMargin;
        // 文字的高
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        // 只有文字cell的高度
        _topicCellH = XKTopicTextY + textH + XKCommonMargin;
        
        // 有中间内容cell的高度
        if (self.type != XKTopicTypeWord) {
            CGFloat pictureW = textW;
            CGFloat pictureH = self.height * pictureW / self.width;
            if (pictureH > XKScreenH) {
                pictureH = 200;
                self.bigPicture = YES;
            }
            CGFloat pictureX = XKCommonMargin;
            CGFloat pictureY = _topicCellH;
            
            self.pictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _topicCellH += pictureH + XKCommonMargin;
        }
        
        _topicCellH += XKTopicToolbarH + XKCommonMargin;
    }
    return _topicCellH;
}
@end
