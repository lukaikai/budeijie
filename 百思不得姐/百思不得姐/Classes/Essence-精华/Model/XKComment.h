//
//  XKComment.h
//  百思不得姐
//
//  Created by MD313  on 15/9/18.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XKUser;

@interface XKComment : NSObject

/** 内容 */
@property(nonatomic, copy) NSString *content;
/** 用户 */
@property(nonatomic,strong) XKUser *user;
/** 被顶次数 */
@property(nonatomic, copy) NSString *like_count;
/** 语音文件的路径 */
@property(nonatomic, copy) NSString *voiceuri;
/** 语音文件的时长 */
@property(nonatomic, copy) NSString *voicetime;

@end
