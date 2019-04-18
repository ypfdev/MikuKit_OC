//
//  UIColor+Addition.h
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/10/29.
//  Copyright © 2018 ypf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Addition)

/**
 快速生成RGB颜色
 
 @param r R
 @param g G
 @param b B
 @param alpha 透明度
 @return RGB颜色
 */
+ (UIColor *)mk_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)alpha;


/**
 使用16进制数字创建颜色，例如 0xFF0000 创建红色
 
 @param hex 16进制数
 @return 颜色
 */
+ (instancetype)mk_colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;


/**
 生成随机颜色
 
 @return 随机颜色
 */
+ (instancetype)mk_randomColor;



@end

NS_ASSUME_NONNULL_END
