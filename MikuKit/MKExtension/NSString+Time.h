//
//  NSString+Time.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/7.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Time)

+ (NSString *)mk_timeStringWithSecond:(NSUInteger)second;

/// 时间戳转日期字符串
/// @param timeStamp 时间戳
/// @param dateFormat 日期格式
+ (NSString *)mk_dateStringWithTimeStamp:(NSString *)timeStamp dateFormat:(NSString *)dateFormat;

/// 日期对象转日期字符串
/// @param date 日期对象
/// @param dateFormat 日期格式
+ (NSString *)mk_dateStringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/// 日期字符串转日期对象
/// @param dateString 日期字符串
/// @param dateFormat 日期格式
+ (NSDate *)mk_dateWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

@end

NS_ASSUME_NONNULL_END
