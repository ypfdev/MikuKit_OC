//
//  NSString+Converter.m
//  PureGarden
//
//  Created by 原鹏飞 on 2017/12/29.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "NSString+Converter.h"
#import <CommonCrypto/CommonDigest.h>   // 计算MD5

@implementation NSString (Converter)

+ (NSString *)mk_jsonStringFromObject:(id)object {
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}

+ (NSString *)mk_32bitMD5StringWithString:(NSString *)string {
    const char *cStr = string.UTF8String;
    unsigned char digit[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digit);
    
    NSMutableString *md5Str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5Str appendFormat:@"%02x", digit[i]];
    }
    
    return [md5Str lowercaseString];    // 转小写
}

+ (NSString *)mk_md5StringWithString:(NSString *)string byteNum:(NSInteger)byteNum isLowercaseStr:(BOOL)isLowercaseStr {
    NSString *md5Str = nil;
    const char *input = [string UTF8String];    // UTF8转码
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digestStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];//直接先获取32位md5字符串,16位是通过它演化而来
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digestStr appendFormat:isLowercaseStr ? @"%02x" : @"%02X", result[i]];//%02x即小写,%02X即大写
    }
    if (byteNum == 32) {
        md5Str = digestStr;
    } else {
        for (int i = 0; i < 24; i++) {
            md5Str = [digestStr substringWithRange:NSMakeRange(8, 16)];
        }
    }
    return md5Str;
}

+ (NSString *)mk_md5StringWithContentsOfFile:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 确保文件存在
    if ([fileManager fileExistsAtPath:filePath isDirectory:nil]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5(data.bytes, (CC_LONG)data.length, digest);
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
            [output appendFormat:@"%02x", digest[i]];
        }
        return output;
    } else {
        return @"";
    }
}

+ (NSString *)mk_stringWithBase64String:(NSString *)base64String {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)mk_base64StringWithString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}


+ (NSString *)mk_formatDateFromDate:(NSTimeInterval)messageTime currTime:(NSTimeInterval)currTime{
    NSString *returnString = @"";
    NSTimeInterval second = currTime - messageTime;
    if(second < 60)
        returnString = NSLocalizedString(@"ui_just_now", @"刚刚");
    else if(second >=60 && second < 3600)
        returnString = [NSString stringWithFormat:@"%.0f%@", second / 60, NSLocalizedString(@"ui_min_ago", @"分钟前")];
    else if(second >= 3600 && second < 3600 * 24)
        returnString = [NSString stringWithFormat:@"%.0f%@", second / (60 * 60), NSLocalizedString(@"ui_hour_ago", @"小时前")];
    else if(second >= 3600 * 24 && second < 3600 * 24 * 3)
        returnString = [NSString stringWithFormat:@"%.0f%@", second / (60 * 60 * 24), NSLocalizedString(@"ui_day_ago", @"天前")];
    else {
        NSDate *messageDate = [NSDate dateWithTimeIntervalSince1970:messageTime];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        returnString = [formatter stringFromDate:messageDate];
    }
    return returnString;
}

- (NSString *)mk_stringByRemovingSpaceAndBreak {
    NSString *newStr;
    newStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return newStr;
}

- (NSString *)mk_stringByDeletingWhitespace {
    NSCharacterSet * characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:characterSet];
}

- (NSMutableAttributedString *)mk_attributedStringWithUnderlineStyle:(NSUnderlineStyle)underlineStyle lineColor:(UIColor *)lineColor {
    // 转可变富文本字符串
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = NSMakeRange(0, [attrString length]);
    // 添加富文本样式
    [attrString addAttribute:NSUnderlineStyleAttributeName
                       value:@(underlineStyle)
                       range:range];
    [attrString addAttribute:NSUnderlineColorAttributeName
                       value:lineColor
                       range:range];
    return attrString;
}


+ (NSString *)mk_stringWithData:(NSData *)data {
    NSMutableString *string = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (!string) {
        string = [[NSMutableString alloc] initWithData:[data mk_cleanUTF8:data] encoding:NSUTF8StringEncoding];
    }
    return string;
}


+ (NSString *)mk_base64StringWithImage:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

- (NSMutableAttributedString *)mk_attributedStringWithRange:(NSRange)range
                                                      color:(UIColor *)color
                                                       font:(UIFont *)font {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:color
                              range:range];
    }
    if (font) {
        [attributedStr addAttribute:NSFontAttributeName
                              value:font
                              range:range];
    }
    return attributedStr;
}

- (NSString *)addingPercentEncoding {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
}

- (NSString *)mk_reverseString {
    if (self.length == 0 || self.length == 1) {
        return self;
    }
    NSMutableString *reverseStr = NSMutableString.alloc.init;
    for (NSInteger index = self.length - 1; index>=0; --index) {
        NSString *currStr = [self substringWithRange:NSMakeRange(index, 1)];
        [reverseStr appendString:currStr];
    }
    return reverseStr;
}

@end
