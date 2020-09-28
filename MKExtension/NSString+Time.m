//
//  NSString+Time.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/7.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)

+ (NSString *)mk_timeStringWithSecond:(NSUInteger)second {
    NSUInteger s = second % 60;
    NSUInteger m = second / 60 % 60;
    
    if (second < 3600) {
        return [NSString stringWithFormat:@"%02ld:%02ld", m, s];
    } else {
        NSUInteger h = second / 3600;
        return [NSString stringWithFormat:@"%ld:%02ld:%02ld", h, m, s];
    }
}

/// 时间戳转日期字符串
/// @param timeStamp 时间戳
/// @param dateFormat 日期格式
+ (NSString *)mk_dateStringWithTimeStamp:(NSString *)timeStamp dateFormat:(NSString *)dateFormat {
    // 时间戳转成秒
    if (timeStamp.length > 10) {
        timeStamp = [timeStamp substringToIndex:10];
    }
    NSTimeInterval second = [timeStamp doubleValue];
    // 时间戳转日期
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    // 日期转指定格式的日期字符串
    NSDateFormatter *dataformatter = [[NSDateFormatter alloc] init];
    dataformatter.dateFormat = dateFormat;
    NSString *dateString = [dataformatter stringFromDate:date];
    return dateString;
}


+ (NSString *)mk_dateStringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:date];
}


+ (NSDate *)mk_dateWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:dateString];
}

@end
