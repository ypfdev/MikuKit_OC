//
//  MCTheme.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 主题
 */
@interface MCTheme : NSObject
#pragma mark - Font
+ (UIFont *)fontWithPX:(NSInteger)px;

#pragma mark - Color
/**
 主题红 - #FF1832
 
 @return 主题红
 */
+ (UIColor *)mainColor;

/**
 蒙版颜色
 
 @return 黑色50%
 */
+ (UIColor *)maskColor;

/**
 主题黑 - #222222
 
 @return 主题黑
 */
+ (UIColor *)color_Black;

/**
 主题深灰 - #666666
 
 @return 主题深灰
 */
+ (UIColor *)color_DarkGray;

/**
 主题浅灰 - #a0a0a0
 
 @return 主题浅灰
 */
+ (UIColor *)color_LightGray;

/**
 主题底色 - #f8f8f8
 
 @return 主题底色
 */
+ (UIColor *)color_Background;

/**
 主题分割线 - #e0e0e0
 
 @return 主题分割线
 */
+ (UIColor *)color_Line;

/**
 主题深金色 - #8a7a59
 
 @return 主题深金色
 */
+ (UIColor *)color_DarkGold;

/**
 主题金色 - #e8c884
 
 @return 主题金色
 */
+ (UIColor *)color_Gold;

/**
 主题浅金色 - #faf4e6
 
 @return 主题浅金色
 */
+ (UIColor *)color_LightGold;

#pragma mark - button
+ (UIColor *)buttonNormalColor;

+ (UIColor *)buttonDisableColor;

#pragma mark - primary
/**
 (#222222)
 导航栏标题
 标签栏未选中
 分段器未选中
 重要数字
 列表标题
 
 @return 主要标题颜色
 */
+ (UIColor *)primaryTitleTextColor;

/**
 (#666666)
 列表副标题
 重要说明文字
 对话文字
 标签文字
 
 @return 主要文本颜色
 */
+ (UIColor *)primaryTextColor;

/**
 (#f8f8f8)
 背景
 文本输入框底色
 
 @return 背景颜色
 */
+ (UIColor *)primaryBackgroundColor;

/**
 (#f5e4d0)
 辅助色
 重要提示背景
 
 @return 辅助色
 */
+ (UIColor *)assistantColor;

#pragma mark - secondary
/**
 (#a0a0a0)
 次要说明文字
 文本输入框提示
 列表内容文字
 
 @return 次要文本颜色
 */
+ (UIColor *)secondaryTextColor;

#pragma mark - 占位图
+ (UIImage *)placeholderImage;


//IOT  冰箱主题色
+ (UIColor *)fridgeMainColor;

#pragma mark - 字体
+ (UIFont *)numberFont:(CGFloat)size;
@end
