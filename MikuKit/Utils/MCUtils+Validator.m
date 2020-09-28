//
//  MCUtils+Validator.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/7/7.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils+Validator.h"

@implementation MCUtils (Validator)

+ (BOOL)mk_validateIDCardNumber:(NSString *)idString {
    idString = [idString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 校验位数
    NSInteger length = 0;
    if (!idString) {
        return NO;
    } else {
        length = idString.length;
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41",@"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:[idString substringToIndex:2]]) {
            areaFlag = YES;
            break;
        }
    }
    if (areaFlag == NO) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [idString substringWithRange:NSMakeRange(6,2)].intValue +1900;
            // 测试出生日期的合法性
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 ==0)) {
                NSString *pattern = @"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$";
                regularExpression = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                NSString *pattern = @"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$";
                regularExpression = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idString options:NSMatchingReportProgress range:NSMakeRange(0, idString.length)];
            if (numberofMatch > 0) {
                return YES;
            } else {
                return NO;
            }
        case 18:
            year = [idString substringWithRange:NSMakeRange(6,4)].intValue;
            // 检查出生日期是否合法
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                NSString *pattern = @"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$";
                regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                NSString *pattern = @"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$";
                regularExpression = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idString options:NSMatchingReportProgress range:NSMakeRange(0, idString.length)];
            if (numberofMatch > 0) {
                int S = ([idString substringWithRange:NSMakeRange(0,1)].intValue + [idString substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([idString substringWithRange:NSMakeRange(1,1)].intValue + [idString substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([idString substringWithRange:NSMakeRange(2,1)].intValue + [idString substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([idString substringWithRange:NSMakeRange(3,1)].intValue + [idString substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([idString substringWithRange:NSMakeRange(4,1)].intValue + [idString substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([idString substringWithRange:NSMakeRange(5,1)].intValue + [idString substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([idString substringWithRange:NSMakeRange(6,1)].intValue + [idString substringWithRange:NSMakeRange(16,1)].intValue) *2 + [idString substringWithRange:NSMakeRange(7,1)].intValue *1 + [idString substringWithRange:NSMakeRange(8,1)].intValue *6 + [idString substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                // 判断校验位
                M = [JYM substringWithRange:NSMakeRange(Y,1)];
                // 检测ID的校验位
                if ([M isEqualToString:[idString substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;
                } else {
                    return NO;
                }
            } else {
                return NO;
            }
        default:
            return NO;
    }
}

+ (BOOL)mk_validateCellphoneNumber:(NSString *)numString {
    if ([MCUtils mk_validateEmpytOrNullRemindString:numString trim:YES]) {
        return NO;
    }
    NSString *format = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
//    NSString *format2 = @"^1[34578]\\d{9}$";
//    NSString *format3 = @"^((1[0-9]))\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    return [predicate evaluateWithObject:numString];
}

+ (BOOL)mk_validateEmail:(NSString *)email {
    if ([MCUtils mk_validateEmpytOrNullRemindString:email trim:YES]) {
        return NO;
    }
    NSString *format = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", format];
    return [predicate evaluateWithObject:email];
}

+ (BOOL)mk_validateEmpytOrNullRemindString:(NSString *)string trim:(BOOL)mTrim {
    if (string == nil) {
        return YES;
    }
    NSRange rangeOfFirstWantedCharacter = [string rangeOfCharacterFromSet:[[NSCharacterSet whitespaceAndNewlineCharacterSet] invertedSet]];
    if (mTrim == YES && rangeOfFirstWantedCharacter.location == NSNotFound) {
        return YES;
    }
    return NO;
}

+ (BOOL)mk_validateOnlyIntNumber:(NSString *)text {
    BOOL result = NO;
    if (![self mk_validateEmpytOrNullRemindString:text trim:YES]){
        NSString * regex = @"^[1-9]\\d*|0$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:text];
    }
    return result;
}

@end
