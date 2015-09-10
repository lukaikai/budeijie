//
//  XKPostWordTextView.h
//  百思不得姐
//
//  Created by MD313  on 15/9/10.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKPlaceholderTextView : UITextView

@property(nonatomic, copy) NSString *placeholder;/**< 占位文字 */
@property(nonatomic,strong) UIColor *placeholderColor;/**< 文字颜色 */
@property(nonatomic,strong) UIFont *placeholderFont;/**< 文字字体 */
@end
