//
//  MCTheme.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCTheme.h"

@implementation MCTheme

#pragma mark - Font
+ (UIFont *)fontWithPX:(NSInteger)px
{
    return [UIFont systemFontOfSize:px/2+2];
}

#pragma mark - Color
/**
 主题红 - #FF1832
 
 @return 主题红
 */
+ (UIColor *)mainColor
{
    return [UIColor mk_colorWithHexString:@"#FF1832"];
}

/**
 蒙版颜色
 
 @return 黑色50%
 */
+ (UIColor *)maskColor
{
    return [UIColor colorWithWhite:0 alpha:0.5];
}

/**
 主题黑 - #222222
 
 @return 主题黑
 */
+ (UIColor *)color_Black
{
    return [UIColor mk_colorWithHexString:@"#222222"];
}

/**
 主题深灰 - #666666
 
 @return 主题深灰
 */
+ (UIColor *)color_DarkGray
{
    return [UIColor mk_colorWithHexString:@"#666666"];
}

/**
 主题浅灰 - #a0a0a0
 
 @return 主题浅灰
 */
+ (UIColor *)color_LightGray
{
    return [UIColor mk_colorWithHexString:@"#a0a0a0"];
}

/**
 主题底色 - #f8f8f8
 
 @return 主题底色
 */
+ (UIColor *)color_Background
{
    return [UIColor mk_colorWithHexString:@"#f8f8f8"];
}

/**
 主题分割线 - #e0e0e0
 
 @return 主题分割线
 */
+ (UIColor *)color_Line
{
    return [UIColor mk_colorWithHexString:@"#e0e0e0"];
}

/**
 主题深金色 - #8a7a59
 
 @return 主题深金色
 */
+ (UIColor *)color_DarkGold
{
    return [UIColor mk_colorWithHexString:@"#8a7a59"];
}

/**
 主题金色 - #e8c884
 
 @return 主题金色
 */
+ (UIColor *)color_Gold
{
    return [UIColor mk_colorWithHexString:@"#e8c884"];
}

/**
 主题浅金色 - #faf4e6
 
 @return 主题浅金色
 */
+ (UIColor *)color_LightGold
{
    return [UIColor mk_colorWithHexString:@"#faf4e6"];
}


#pragma mark - button
+ (UIColor *)buttonNormalColor
{
    return [self mainColor];
}

+ (UIColor *)buttonDisableColor
{
    return [self color_LightGray];
}

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
+ (UIColor *)primaryTitleTextColor
{
    return [self color_Black];
}

/**
 (#666666)
 列表副标题
 重要说明文字
 对话文字
 标签文字
 
 @return 主要文本颜色
 */
+ (UIColor *)primaryTextColor
{
    return [self color_DarkGray];
}

/**
 (#f8f8f8)
 背景
 文本输入框底色
 
 @return 背景颜色
 */
+ (UIColor *)primaryBackgroundColor
{
    return [self color_Background];
}

/**
 (#f5e4d0)
 辅助色
 重要提示背景
 
 @return 辅助色
 */
+ (UIColor *)assistantColor
{
    return [UIColor mk_colorWithHexString:@"#f5e4d0"];
}

#pragma mark - secondary
/**
 (#a0a0a0)
 次要说明文字
 文本输入框提示
 列表内容文字

 @return 次要文本颜色
 */
+ (UIColor *)secondaryTextColor
{
    return [self color_LightGray];
}

#pragma mark - 占位图

+ (UIImage *)placeholderImage {
    return [UIImage imageNamed:@"ic_album_placeholder"];
}

//IOT  冰箱主题色
+ (UIColor *)fridgeMainColor {
    return [UIColor mk_colorWithHexString:@"#01B7C4"];
}

#pragma mark - 字体

+ (UIFont *)numberFont:(CGFloat)size {
    return [UIFont fontWithName:@"DIN Alternate" size:size];
}

@end
