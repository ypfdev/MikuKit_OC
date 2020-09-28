//
//  MCUtils.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/9.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <StoreKit/StoreKit.h>
#import <UserNotifications/UserNotifications.h>
#import "NSString+Converter.h"

@implementation MCUtils

+ (MKDisplayMode)mk_displayMode {
    NSString *screenMode = [[UIScreen mainScreen].coordinateSpace description];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat nativeScale = [[UIScreen mainScreen] nativeScale];
    PFLog(@"screen mode: %@\n\tbounds: %@\n\tscale: %f\n\tnative scale: %f", screenMode, NSStringFromCGRect(bounds), scale, nativeScale);
    /** iPhone6标准模式输出
     screen mode: <UIScreen: 0x10490ab30; bounds = {{0, 0}, {375, 667}}; mode = <UIScreenMode: 0x280c515a0; size = 750.000000 x 1334.000000>>
     bounds: {{0, 0}, {375, 667}}
     scale: 2.000000
     native scale: 2.000000
     */
    /** iPhone6放大模式输出
     screen mode: <UIScreen: 0x104006910; bounds = {{0, 0}, {320, 568}}; mode = <UIScreenMode: 0x281f34900; size = 640.000000 x 1136.000000>>
     bounds: {{0, 0}, {320, 568}}
     scale: 2.000000
     native scale: 2.343750
     */
    /** iPhone6 Plus标准模式输出
     screen mode: <UIScreen: 0x13ee01840; bounds = { {0, 0}, {414, 736} }; mode = <UIScreenMode: 0x17002b4e0; size = 1242.000000 x 2208.000000>>
     bounds: { {0, 0}, {414, 736} }
     scale: 3.000000
     native scale: 2.608696
     */
    /** iPhone6 Plus放大模式输出
     screen mode: <UIScreen: 0x13f6021f0; bounds = { {0, 0}, {375, 667} }; mode = <UIScreenMode: 0x170028c20; size = 1125.000000 x 2001.000000>>
     bounds: { {0, 0}, {375, 667} }
     scale: 3.000000
     native scale: 2.880000
     */
    if (remainderf(nativeScale, 1) == 0) {
        return MKDisplayModeStandard;
    } else {
        return MKDisplayModeZoomed;
    }
}

+ (NSString *)mk_appName {
    return [NSBundle mainBundle].infoDictionary[(__bridge NSString*)kCFBundleNameKey];
}

+ (void)mk_starWithinAppStore {
    // 应用的AppleID
    NSString *appID = @"1465067070";
    
    if (@available(iOS 10.3,*)) {
        // 只能评分不能评论，一年内只能使用3次，超出后需要跳转到AppleStore
        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
            [[UIApplication sharedApplication].keyWindow endEditing:YES];   // 防止键盘遮挡
            [SKStoreReviewController requestReview];
        }
    } else {
        // 可评分&评论，无次数限制
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"喜欢APP么? 给个五星好评吧亲!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        // 评价操作（跳转到APPStore中撰写评价页面）
        UIAlertAction *reviewAction = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *appReviewURL = [NSURL URLWithString:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review", appID]];
            if ([[UIApplication sharedApplication] canOpenURL:appReviewURL]) {
                if (@available(iOS 10.0,*)) {
                    [[UIApplication sharedApplication] openURL:appReviewURL options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:appReviewURL];
                }
            }
        }];
        [alertC addAction:reviewAction];
        // 取消操作
        UIAlertAction *notNowAction = [UIAlertAction actionWithTitle:@"用用再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alertC removeFromParentViewController];
        }];
        [alertC addAction:notNowAction];
        // 显示弹窗
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *vc = [MCUtils mk_currentVC];
            [vc presentViewController:alertC animated:YES completion:nil];
        });
    }
}

#pragma mark - 获取App通知权限

+ (void)readNotificationAuthorization:(void(^)(BOOL flag))completionHandle {
    if (@available(iOS 10,*)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
                if (completionHandle) {
                    completionHandle(YES);
                }
            } else {
                if (completionHandle) {
                    completionHandle(NO);
                }
            }
        }];
    } else if (@available(iOS 8,*)) {
        if ([UIApplication sharedApplication].currentUserNotificationSettings.types  == UIUserNotificationTypeNone) {
            if (completionHandle) {
                completionHandle(NO);
            }
        } else {
            if (completionHandle) {
                completionHandle(YES);
            }
        }
    } else {
        if ([UIApplication sharedApplication].enabledRemoteNotificationTypes == UIRemoteNotificationTypeNone) {
            if (completionHandle) {
                completionHandle(NO);
            }
        } else {
            if (completionHandle) {
                completionHandle(YES);
            }
        }
    }
}


#pragma mark - 更换根控制器（平滑过度）

+ (void)mk_changeRootController:(UIViewController *)rootVC {
    CATransition *transtition = [CATransition animation];
    transtition.duration = 0.5;
    transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtition forKey:@"animation"];
}


#pragma mark - 获取控制器

+ (UIViewController *)mk_currentVC {
//    UIWindow *window1 = [UIApplication sharedApplication].delegate.window;
    // 和上面那种写法获取到的window是同一个
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray<UIWindow *> *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *currentVC = nil;
    UIViewController *rootVC = window.rootViewController;
    do {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navC = (UINavigationController *)rootVC;
            UIViewController *vc = [navC.viewControllers lastObject];
            currentVC = vc;
            rootVC = vc.presentedViewController;
            continue;
        } else if([rootVC isKindOfClass:[UITabBarController class]]){
            UITabBarController *tabVC = (UITabBarController *)rootVC;
            currentVC = tabVC;
            rootVC = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (rootVC != nil);
    
    return currentVC;
}

#pragma mark - 用户
+ (NSString *)interceptUserName:(NSString *)userName{
    NSString *name = [[userName componentsSeparatedByString:@"("]objectAtIndex:0];
    if (name.length >2) {
        NSArray *array = [name componentsSeparatedByString:@"] "];
        if (array.count == 2) {
            name = array[1];
        }
        NSString *match = @"[a-zA-Z]*";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
        BOOL isEnglish = [predicate evaluateWithObject:name];
        if (isEnglish) {
            return [[name substringWithRange:NSMakeRange(0,2)]uppercaseString];
        }else{
            return [name substringWithRange:NSMakeRange(name.length-2,2)];
        }
    } else {
        return name;
    }
}

#pragma mark - 横竖屏

/// 设置屏幕方向（PS：屏幕方向改变时系统会发送通知UIDeviceOrientationDidChangeNotification）
/// l@param orientation 用户界面方向枚举值
+ (void)mk_changeDeviceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        NSUInteger value = orientation;
        SEL seletor = NSSelectorFromString(@"setOrientation:");
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:seletor]];
        [invocation setSelector:seletor];
        [invocation setTarget:[UIDevice currentDevice]];
        [invocation setArgument:&value atIndex:2];
        [invocation invoke];
    } else {
        PFLog(@"CurrentDevice");
    }
}

#pragma mark - 时间转换

+ (NSString *)mk_currentTimeStringWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSString *)mk_timeStringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:date];
}

+ (NSDate *)mk_dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    NSDate *destDate= [formatter dateFromString:dateString];
    return destDate;
}

+ (NSInteger)mk_timeStampWithDate:(NSDate *)date leval:(MKTimeStampLeval)leval {
    NSTimeInterval secondCount = [date timeIntervalSince1970];
    NSInteger timeStamp = 0;
    if (leval == MKTimeStampLevalSecond) {
        timeStamp = [[NSNumber numberWithDouble:secondCount] integerValue] * 1000;
    }
    if (leval == MKTimeStampLevalMillisecond) {
        timeStamp = [[NSNumber numberWithDouble:secondCount] integerValue];
    }
    return timeStamp;
}


+ (NSInteger)mk_timeStampWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    formatter.dateFormat = dateFormat;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    NSDate *date = [formatter dateFromString:dateString];
    NSTimeInterval secondCount = [date timeIntervalSince1970];
    // 时间转时间戳
    NSInteger timeSp = [[NSNumber numberWithDouble:secondCount] integerValue] * 1000;
    return timeSp;
}

/**
 将某个时间戳转化成时间
 
 @param timestamp 时间戳
 @param format 格式化方式
 @return 时间
 */
+ (NSString *)getTimeWithTimestamp:(NSString *)timestamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

/**
 判断时间差
 
 @param date1String 时间字符串
 @param date2String 时间字符串
 @return 时间差
 */
+ (NSInteger)differenceWithDate:(NSString *)date1String withDate:(NSString *)date2String{
    
    NSDate *date1 = [MCUtils mk_dateWithString:date1String dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [MCUtils mk_dateWithString:date2String dateFormat:@"yyyy-MM-dd "];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:date2 toDate:date1 options:0];
    NSInteger day = [comps day];//时间差
    PFLog(@"时间差 = %ld",(long)day);
    return day;
}

/**
 比较两个日期的大小 日期格式为2016-08-14
 
 @param aDate a日期
 @param bDate b日期
 @return 0：相等；1：b比a大；-1：b比a小
 */
+ (NSInteger)compareDate:(NSString *)aDate withDate:(NSString *)bDate{
    NSInteger aa;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    
    NSComparisonResult result = [[dateformater dateFromString:aDate] compare:[dateformater dateFromString:bDate]];
    
    if (result==NSOrderedSame) {
        //相等
        aa = 0;
    } else if (result==NSOrderedAscending) {
        //bDate比aDate大
        aa = 1;
    } else {
        //bDate比aDate小
        aa = -1;
    }
    
    return aa;
}

/**
 时间差
 
 @param startTime 开始时间
 @param endTime 结束时间
 @return 秒
 */
+ (NSTimeInterval)secondWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD = [date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval value = [endD timeIntervalSinceDate:startD];
    
    return value;
}

/**
 获取天时分秒
 
 @param value 秒
 @return 时间
 */
+ (NSString *)getDayHourMinuteSecondWithSecond:(int)value{
    int second = (int)value % 60;//秒
    int minute = (int)value / 60%60;
    int hour = (int)value / 3600%24;
    int day = (int)value / (24*3600);
    NSString *str;
    if (day > 0) {
        str = [NSString stringWithFormat:@"%d天%d时%d分%d秒",day,hour,minute,second];
    }else if (day==0 && hour > 0) {
        str = [NSString stringWithFormat:@"%d时%d分%d秒",hour,minute,second];
    }else if (day==0 && hour==0 && minute>0) {
        str = [NSString stringWithFormat:@"%d分%d秒",minute,second];
    }else if (day==0 && hour==0 && minute==0 && second>0){
        str = [NSString stringWithFormat:@"%d秒",second];
    }
    return str;
}


+ (NSDictionary<NSString *, NSString *> *)getTimeDictWithSecond:(double)value {
    NSInteger day = (NSInteger)value / (24 * 3600);
    NSInteger hour = (NSInteger)value / 3600 % 24;
    NSInteger minute = (NSInteger)value / 60 % 60;
    NSInteger second = (NSInteger)value % 60;
    
    return @{@"day":[NSString stringWithFormat:@"%zd",day],
             @"hour":[NSString stringWithFormat:@"%zd",hour],
             @"minute":[NSString stringWithFormat:@"%zd",minute],
             @"second":[NSString stringWithFormat:@"%zd",second]
             };
}


/**
 获取星期几
 
 @param timeString 时间戳(秒)
 @return 周几
 */
+ (NSString *)weekdayStringFromDate:(NSString *)timeString{
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)([timeString doubleValue]/1000)];
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六",  nil];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:nd];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


#pragma mark - 计算label宽高
//size
+ (CGSize)calLabelSize:(UIFont *)fontSize andStr:(NSString *)str withWidth:(CGFloat)widthSize{
    NSDictionary *attribute = @{NSFontAttributeName: fontSize};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(widthSize, 1000)
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize;
}
//label高
+ (CGFloat)calLabelHeight:(UIFont *)fontSize andStr:(NSString *)str withWidth:(CGFloat)widthSize lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *contentParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    contentParagraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attribute = @{NSFontAttributeName:fontSize, NSParagraphStyleAttributeName:contentParagraphStyle};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(widthSize, 1000)
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize.height;
}

+ (CGFloat)calLabelHeight:(UIFont *)fontSize andStr:(NSString *)str withWidth:(CGFloat)widthSize{
    return [self calLabelHeight:fontSize andStr:str withWidth:widthSize lineSpacing:0];
}

+ (CGFloat)calLabelHeight:(UIFont *)fontSize andStr:(NSString *)str{
    
    
    NSDictionary *attribute = @{NSFontAttributeName: fontSize};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width- 10, 0)
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize.height;
    
    
    
}

+ (CGFloat)calLabelHeight:(UIFont *)fontSize andStr:(NSString *)str withWidth:(CGFloat)widthSize WithHeight:(CGFloat)heightSize
{
    NSDictionary *attribute = @{NSFontAttributeName: fontSize};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(widthSize, heightSize)
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize.height;
}

//label宽度
+ (CGFloat)calLabelWidth:(UIFont *)fontSize andStr:(NSString *)str withHight:(CGFloat)height{
    
    
    NSDictionary *attribute = @{NSFontAttributeName: fontSize};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(0, height)
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize.width;
}

#pragma mark - 加密
+ (NSString *)encryptionCode:(NSString *)pw {
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    NSString *key = @"IVZfUKUcqNRqkbICfmGeHfMAPFxt3V";
    NSMutableArray *odds = [NSMutableArray array];//奇数
    NSMutableArray *evens = [NSMutableArray array];//偶数
    for (int i = 0; i < key.length; i++) {
        NSString *temp = [key substringWithRange:NSMakeRange(i, 1)];
        if (i%2 == 0) {
            [evens addObject:temp];
        }else {
            [odds addObject:temp];
        }
    }
    for (int i = 0; i < pw.length; i++) {
        NSString *temp = [pw substringWithRange:NSMakeRange(i, 1)];
        if (i<odds.count) {
            [odds replaceObjectAtIndex:i withObject:temp];
        }else {
            [evens replaceObjectAtIndex:i-15 withObject:temp];
        }
    }
    NSMutableArray *newArray = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        NSString *even = [evens objectAtIndex:i];
        [newArray addObject:even];
        NSString *odd = [odds objectAtIndex:i];
        [newArray addObject:odd];
    }

    NSString *string = [newArray componentsJoinedByString:@""];
    NSString *lengthKey = [array objectAtIndex:pw.length-1];
    int x = arc4random() % 30;
    NSString *randomKey = [key substringWithRange:NSMakeRange(x, 1)];
    string = [NSString stringWithFormat:@"%@%@%@", randomKey, [NSString mk_base64StringWithString:string], lengthKey];
    return [NSString mk_base64StringWithString:string];
}


/**
 密码正则
 
 @param inputString 电话号码
 */
+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString {
    
    if (inputString.length == 0) return NO;
    
    NSString *regex =@"[a-zA-Z0-9]*";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [pred evaluateWithObject:inputString];
}

@end
