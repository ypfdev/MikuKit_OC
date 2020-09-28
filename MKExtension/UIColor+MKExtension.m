//
//  UIColor+MKExtension.m
//  Miku
//
//  Created by 原鹏飞 on 16/4/21.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import "UIColor+MKExtension.h"

@implementation UIColor (MKExtension)

+ (UIColor *)mk_colorWithRed:(uint8_t)red
                       green:(uint8_t)green
                        blue:(uint8_t)blue {
    return [UIColor colorWithRed:red / 255.0
                           green:green / 255.0
                            blue:blue / 255.0
                           alpha:1.0];
}

+ (UIColor *)mk_randomColor {
    return [UIColor mk_colorWithRed:arc4random_uniform(256)
                              green:arc4random_uniform(256)
                               blue:arc4random_uniform(256)];
}

+ (UIColor *)mk_colorWithHex:(uint32_t)hex {
    uint8_t r = (hex & 0xff0000) >> 16;
    uint8_t g = (hex & 0x00ff00) >> 8;
    uint8_t b = hex & 0x0000ff;
    return [UIColor mk_colorWithRed:r
                              green:g
                               blue:b];
}

+ (UIColor *)mk_colorWithHex:(uint32_t)hex
                       alpha:(CGFloat)alpha {
    uint8_t r = (hex & 0xff0000) >> 16;
    uint8_t g = (hex & 0x00ff00) >> 8;
    uint8_t b = hex & 0x0000ff;
    return [UIColor colorWithRed:r / 255.0
                           green:g / 255.0
                            blue:b / 255.0
                           alpha:alpha];
}

+ (UIColor *)mk_colorWithHexString:(NSString *)hexString {
    return [UIColor mk_colorWithHexString:hexString
                                    alpha:1.0];
}

+ (UIColor *)mk_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    // 过滤去掉空格
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 小写字母转大写
    hexString = [hexString uppercaseString];
    
    // 处理前缀
    if ([hexString hasPrefix:@"0X"] || [hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    // String should be 6 or 8 characters
    if ([hexString length] != 6 && [hexString length] != 8) {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.length = 2;
    // R
    range.location = 0;
    NSString *redStr = [hexString substringWithRange:range];
    // G
    range.location = 2;
    NSString *greenStr = [hexString substringWithRange:range];
    // B
    range.location = 4;
    NSString *blueStr = [hexString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:redStr] scanHexInt:&r];
    [[NSScanner scannerWithString:greenStr] scanHexInt:&g];
    [[NSScanner scannerWithString:blueStr] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}


#pragma mark - 颜色转字符串

/**
 根据颜色获取对应的6位HexString
 
 @return 6位HexString，形如#00FF00
 */
+ (NSString *)mk_6bitHexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    CGFloat a = components[3];
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX", lroundf(a * 255), lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
}


/**
 根据颜色获取对应的8位HexString（前2位表示alpha，后6位表示RGB）
 
 @return 8位HexString，形如#FF00FF00
 */
+ (NSString *)mk_8bitHhexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    // 因0x00转换后为0，所以格式化字符串时要补足两位00
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
}


#pragma mark - 未确认

+ (UIColor *)mk_test1_colorWithHexString:(NSString *)hexString {
    UIColor *color = [UIColor new];
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    if (nil != hexString) {
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    color = [UIColor colorWithRed: (float)redByte / 0xff
                             green: (float)greenByte/ 0xff
                              blue: (float)blueByte / 0xff
                             alpha:1.0];
    return color;
}


- (UIColor *)mk_test2_colorWithHexString:(NSString *)hexString {
    // 先判断hexString是否包含alpha位
    BOOL alphaFlag;
    NSString *subString = [NSString new];
    if ([hexString hasPrefix:@"0X"] || [hexString hasPrefix:@"0x"]) {
        if (hexString.length >= 10) {
            alphaFlag = YES;
            subString = [hexString substringToIndex:10];
        } else if (hexString.length >= 8) {
            alphaFlag = NO;
            subString = [hexString substringToIndex:8];
        } else {
            return [UIColor clearColor];
        }
    } else if ([hexString hasPrefix:@"#"]) {
        if (hexString.length >= 9) {
            alphaFlag = YES;
            subString = [hexString substringToIndex:9];
        } else if (hexString.length >= 7) {
            alphaFlag = NO;
            subString = [hexString substringToIndex:7];
        } else {
            return [UIColor clearColor];
        }
    } else {
        return [UIColor clearColor];
    }
    
    unsigned int colorCode = 0;
    NSScanner *scanner = [NSScanner scannerWithString:subString];
    [scanner scanHexInt:&colorCode];
    unsigned char redByte, greenByte, blueByte, alphaByte;
    if (alphaFlag) {
        uint8_t r = (colorCode & 0xff000000) >> 24;
        uint8_t g = (colorCode & 0x00ff0000) >> 16;
        uint8_t b = (colorCode & 0x0000ff00) >> 8;
        uint8_t a = colorCode & 0x000000ff;
        UIColor *color1 = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a / 255.0f];
        return color1;
    } else {
        redByte = (unsigned char) (colorCode >> 16);
        greenByte = (unsigned char) (colorCode >> 8);
        blueByte = (unsigned char) (colorCode);
        UIColor *color2 = [UIColor colorWithRed: (float)redByte / 0xff
                                         green: (float)greenByte/ 0xff
                                          blue: (float)blueByte / 0xff
                                         alpha:1.0];
        return color2;
    }
}

+ (CGFloat)colorComponentFromString:(NSString *)string
                           location:(NSUInteger)loc
                             length:(NSUInteger)len {
    NSString *substring = [string substringWithRange: NSMakeRange(loc, len)];
    NSString *fullHex = [NSString new];
    if (len == 2) {
        fullHex = substring;
    } else {
        fullHex = [NSString stringWithFormat: @"%@%@", substring, substring];
    }
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    CGFloat f = hexComponent / 255.0;
    return f;
}

@end
