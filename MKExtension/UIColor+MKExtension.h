//
//  UIColor+MKExtension.h
//  MK
//
//  Created by 原鹏飞 on 16/4/21.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MKExtension)

#pragma mark - 快速生成颜色对象

/// 快速生成RGB颜色（透明度1.0）
/// @param red R通道值
/// @param green G通道值
/// @param blue B通道值
+ (UIColor *)mk_colorWithRed:(uint8_t)red
                       green:(uint8_t)green
                        blue:(uint8_t)blue;

/// 快速生成随机RGB颜色
+ (UIColor *)mk_randomColor;

/// 16进制数转RGB颜色（透明度1.0）
/// @param hex 16进制32位无符号整数（形如0x00FF00）
+ (UIColor *)mk_colorWithHex:(uint32_t)hex;

/// 16进制数转RGB颜色
/// @param hex 16进制32位无符号整数（形如0x00FF00）
/// @param alpha 透明度（0 ~ 1.0）
+ (UIColor *)mk_colorWithHex:(uint32_t)hex
                       alpha:(CGFloat)alpha;

/// hexString转UIColor（透明度1.0）
/// @param hexString 16进制数字符串（6位/8位）
+ (UIColor *)mk_colorWithHexString:(NSString *)hexString;

/// hexString转UIColor
/// @param hexString 16进制数字符串（6位/8位，形如@"0x00FF00"、@"#00FF00"或@"00FF00"）
/// @param alpha 透明度（0 ~ 1.0）
+ (UIColor *)mk_colorWithHexString:(NSString *)hexString
                             alpha:(CGFloat)alpha;


#pragma mark - 颜色转字符串

/// UIColor转6位16进制字符串
/// @param color 颜色对象
+ (NSString *)mk_6bitHexStringFromColor:(UIColor *)color;

/// UIColor转8位16进制字符串（前2位表示alpha，后6位表示RGB）
/// @param color 颜色对象
+ (NSString *)mk_8bitHhexStringFromColor:(UIColor *)color;


#pragma mark - 未确认

/**
 Converts a color component from a hex string to a float ranging from 0.00 to 1.00
 
 @param string A hex color string
 @param loc  character index of the component
 @param len 1 or 2 characters
 
 @return A float ranging from 0.00 to 1.00
 */
+ (CGFloat)colorComponentFromString:(NSString *)string
                           location:(NSUInteger)loc
                             length:(NSUInteger)len;



@end
