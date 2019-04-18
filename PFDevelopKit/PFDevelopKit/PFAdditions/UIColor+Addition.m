//
//  UIColor+Addition.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/10/29.
//  Copyright © 2018 ypf. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)

/**
 快速生成RGB颜色
 
 @param r R
 @param g G
 @param b B
 @param alpha 透明度
 @return RGB颜色
 */
+ (UIColor *)mk_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue: b / 255.0 alpha:alpha];
}


/**
 使用16进制数字创建颜色，例如 0xFF0000 创建红色
 
 @param hex 16进制数
 @return 颜色
 */
+ (instancetype)mk_colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha {
    
    uint8_t r = (hex & 0xff0000) >> 16;
    uint8_t g = (hex & 0x00ff00) >> 8;
    uint8_t b = hex & 0x0000ff;
    
    return [self mk_colorWithRed:r green:g blue:b alpha:alpha];
}


/**
 生成随机颜色
 
 @return 随机颜色
 */
+ (instancetype)mk_randomColor {
    return [UIColor mk_colorWithRed:arc4random_uniform(256) green:arc4random_uniform(256) blue:arc4random_uniform(256) alpha:1.0];
}

@end
