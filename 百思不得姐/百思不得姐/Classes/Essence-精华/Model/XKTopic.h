//
//  XKTopic.h
//  百思不得姐
//
//  Created by MD313  on 15/9/14.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKComment.h"
typedef enum {
    XKTopicTypePicture = 10, // 图片
    XKTopicTypeWord = 29, // 段子(文字)
    XKTopicTypeVoice = 31, // 声音
    XKTopicTypeVideo = 41 //视频
} XKTopicType;

@interface XKTopic : NSObject

/** 昵称 */
@property(nonatomic, copy) NSString *name;
/** 头像 */
@property(nonatomic, copy) NSString *profile_image;
/** 帖子审核通过的时间 */
@property(nonatomic, copy) NSString *created_at;
/** 帖子内容 */
@property(nonatomic, copy) NSString *text;
/** 顶 */
@property(nonatomic, assign) NSInteger ding;
/** 踩 */
@property(nonatomic, assign) NSInteger cai;
/** 分享数 */
@property(nonatomic, assign) NSInteger repost;
/** 评论数 */
@property(nonatomic, assign) NSInteger comment;
/** 帖子类型*/
@property(nonatomic, assign) XKTopicType type;
/** 图片的高度 */
@property(nonatomic, assign) CGFloat height;
/** 图片的宽度 */
@property(nonatomic, assign) CGFloat width;
/** 小图 */
@property(nonatomic, copy) NSString *small_image; //image0
/** 大图 */
@property(nonatomic, copy) NSString *large_image; // image1
/** 中图 */
@property(nonatomic, copy) NSString *middle_image; // image2
/** 是否是gif图片 */
@property(nonatomic, assign) BOOL is_gif;
/** 视频时长 */
@property(nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property(nonatomic, assign) NSInteger playcount;
/** id */
@property(nonatomic, copy) NSString *ID; // id
/** 最热评论 存放XKComment模型*/
@property(nonatomic,strong) XKComment *topComment;



/** 辅助属性 */
@property(nonatomic, assign) CGFloat topicCellH;
/** 中间图片的frame */
@property(nonatomic, assign) CGRect pictureFrame;
/** 是否是大图 */
@property(nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
@end
