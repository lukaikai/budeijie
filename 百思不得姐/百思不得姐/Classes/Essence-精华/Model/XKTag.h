//
//  XKTag.h
//  百思不得姐
//
//  Created by MD313  on 15/9/6.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKTag : NSObject

@property(nonatomic, copy) NSString *image_list;/**< 头像 */
@property(nonatomic, copy) NSString *theme_name;/**< 名字 */
@property(nonatomic, assign) NSInteger sub_number;/**< 订阅数 */

@end
