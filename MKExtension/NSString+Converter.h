//
//  NSString+Converter.h
//  PureGarden
//
//  Created by 原鹏飞 on 2017/12/29.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Converter)

/// 对象转json字符串
/// @param object 对象
+ (NSString *)mk_jsonStringFromObject:(id)object;

/// OC字符串转MD5字符串（MD5加密）
/// @param string OC字符串
/// @param byteNum 位数，16 or 32
/// @param isLowercaseStr 是否小写
+ (NSString *)mk_md5StringWithString:(NSString *)string byteNum:(NSInteger)byteNum isLowercaseStr:(BOOL)isLowercaseStr;

/// 计算文件的MD5
/// @param filePath 目标文件路径
+ (NSString *)mk_md5StringWithContentsOfFile:(NSString *)filePath;

/// Base64字符串转OC字符串
/// @param base64String Base64字符串
+ (NSString *)mk_stringWithBase64String:(NSString *)base64String;

/// OC字符串转Base64字符串
/// @param string OC字符串
+ (NSString *)mk_base64StringWithString:(NSString *)string;

// 返回自定义时间字符串（例如：刚刚、n分钟前、n小时前、n天前、yyyy-MM-dd）
+ (NSString *)mk_formatDateFromDate:(NSTimeInterval)messageTime
                           currTime:(NSTimeInterval)currTime;

/// 移除空格、换行、回车
- (NSString *)mk_stringByRemovingSpaceAndBreak;

/// 移除字符串的左右空格和换行符
- (NSString *)mk_stringByDeletingWhitespace;

/// 生成带下划线的富文本
/// @param underlineStyle 下划线样式（位移枚举，例如：NSUnderlinePatternSolid | NSUnderlineStyleSingle）
/// @param lineColor 下划线颜色
- (NSMutableAttributedString *)mk_attributedStringWithUnderlineStyle:(NSUnderlineStyle)underlineStyle lineColor:(UIColor *)lineColor;

+ (NSString *)mk_stringWithData:(NSData *)data;

/// 图片转base64字符串
/// @param image 目标图片
+ (NSString *)mk_base64StringWithImage:(UIImage *)image;

/**
 string转富文本
 
 @param range 字符位置
 @param color 颜色
 @param font 字体
 @return 富文本
 */

/// 生成富文本字符串
/// @param range 目标区间
/// @param color 颜色
/// @param font 字体
- (NSMutableAttributedString *)mk_attributedStringWithRange:(NSRange)range
                                                      color:(UIColor *)color
                                                       font:(UIFont *)font;

/// <#Description#>
- (NSString *)addingPercentEncoding;

/// 反转字符串
- (NSString *)mk_reverseString;

@end
