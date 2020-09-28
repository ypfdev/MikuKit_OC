//
//  MCUtils.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/9.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

/** DISPLAY ZOOM
 Choose a view for iPhone. Zoomed shows larger controls. Standard shows more content.
 */
typedef NS_ENUM(NSUInteger, MKDisplayMode) {
    MKDisplayModeStandard   = 0,    // 标准模式（默认）
    MKDisplayModeZoomed     = 1,    // 放大模式
};


typedef NS_ENUM(NSUInteger, MKTimeStampLeval) {
    MKTimeStampLevalSecond      = 0,    // 秒
    MKTimeStampLevalMillisecond = 1,    // 毫秒
};

@interface MCUtils : NSObject

+ (MKDisplayMode)mk_displayMode;
+ (NSString *)mk_appName;

#pragma mark - 应用内评分

/// 应用内评分
+ (void)mk_starWithinAppStore;

#pragma mark - 获取App通知权限

+ (void)readNotificationAuthorization:(void(^)(BOOL flag))completionHandle;

#pragma mark - 更换根控制器（平滑过度）

+ (void)mk_changeRootController:(UIViewController *)rootVC;

#pragma mark - 获取控制器

/// 获取当前页面的控制器
+ (UIViewController *)mk_currentVC;

#pragma mark - 用户

/// 截取用户名
/// @param userName 字符串
+ (NSString *)interceptUserName:(NSString *)userName;

#pragma mark - 横竖屏

+ (void)mk_changeDeviceOrientation:(UIInterfaceOrientation)orientation;

#pragma mark - 时间转换

/// 获取当前时间的格式化字符串
/// @param dateFormat 日期格式
+ (NSString *)mk_currentTimeStringWithDateFormat:(NSString *)dateFormat;

/// 获取指定时间的格式化字符串
/// @param date 指定日期
/// @param dateFormat 日期格式
+ (NSString *)mk_timeStringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/// 格式化时间字符串转日期
/// @param dateString 格式化时间字符串
/// @param dateFormat 日期格式
+ (NSDate *)mk_dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat;


/// 日期转时间戳
/// @param date 日期对象
/// @param leval 秒/毫秒
+ (NSInteger)mk_timeStampWithDate:(NSDate *)date leval:(MKTimeStampLeval)leval;

/// 当前时间戳
+ (NSInteger)mk_currentTimeStamp;


/// 格式化时间字符串转时间戳
/// @param dateString 格式化时间字符串
/// @param dateFormat 日期格式
+ (NSInteger)mk_timeStampWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat;



/**
 将某个时间戳转化成时间
 
 @param timestamp 时间戳
 @param format 格式化方式
 @return 时间
 */
+ (NSString *)getTimeWithTimestamp:(NSString *)timestamp andFormatter:(NSString *)format;


/**
 获取星期几
 
 @param timeString 时间戳(秒)
 @return 周几
 */
+ (NSString *)weekdayStringFromDate:(NSString *)timeString;


/**
 判断时间差
 
 @param date1String 时间字符串
 @param date2String 时间字符串
 @return 时间差
 */
+ (NSInteger)differenceWithDate:(NSString*)date1String withDate:(NSString*)date2String;

/**
 比较两个日期的大小 日期格式为2016-08-14
 
 @param aDate a日期
 @param bDate b日期
 @return 0：相等；1：b比a大；-1：b比a小
 */
+ (NSInteger)compareDate:(NSString *)aDate withDate:(NSString *)bDate;

/**
 时间差
 
 @param startTime 开始时间
 @param endTime 结束时间
 @return 秒
 */
+ (NSTimeInterval)secondWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/// 秒数转时长字符串（天时分秒）
/// @param value <#value description#>
+ (NSString *)getDayHourMinuteSecondWithSecond:(int)value;

+ (NSDictionary<NSString *, NSString *> *)getTimeDictWithSecond:(double)value;


#pragma mark - 计算label宽高
//size
+ (CGSize)calLabelSize:(UIFont *)fontSize andStr:(NSString *)str withWidth:(CGFloat)widthSize;
//高
+ (CGFloat)calLabelHeight:(UIFont *)fontSize andStr:(NSString *)str withWidth:(CGFloat)widthSize lineSpacing:(CGFloat)lineSpacing;
//高
+ (CGFloat)calLabelHeight:(UIFont *)fontSize andStr:(NSString *)str withWidth:(CGFloat)widthSize;
//高
+ (CGFloat)calLabelHeight:(UIFont *)fontSize andStr:(NSString *)str;
//高
+ (CGFloat)calLabelHeight:(UIFont *)fontSize andStr:(NSString *)str withWidth:(CGFloat)widthSize WithHeight:(CGFloat)heightSize;
//宽
+ (CGFloat)calLabelWidth:(UIFont *)fontSize andStr:(NSString *)str withHight:(CGFloat)height;


#pragma mark - 加密

+ (NSString *)encryptionCode:(NSString *)pw;

/**
 密码正则
 
 @param inputString 电话号码
 */
+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString;

@end
