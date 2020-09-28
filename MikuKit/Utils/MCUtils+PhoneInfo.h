//
//  MCUtils+PhoneInfo.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/9/18.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PFLanguage) {
    PFLanguageSimplifiedChinese     = 0,    // 中文（简体）
    PFLanguageTraditionalChinese    = 1,    // 中文（繁体）
    PFLanguageEnglish               = 2,    // 英语
    PFLanguageFrench                = 3,    // 法语
    PFLanguageGerman                = 4,    // 德语
    PFLanguageSpanish               = 5,    // 西班牙语
    PFLanguagePortuguese            = 6,    // 葡萄牙语
    PFLanguageItalian               = 7,    // 意大利语
    PFLanguageJapanese              = 8,    // 日语
    PFLanguageKorean                = 9,    // 韩语
};

@interface MCUtils (PhoneInfo)

#pragma mark - 获取手机信息

// MARK: App相关



// MARK: 系统相关
+ (NSString *)uuid;                 // UUID
+ (NSString *)systemVersion;        // 手机系统版本号
+ (NSString *)preferredLanguage;    // 获取系统首选语言
+ (NSString *)languageCode;         // 获取手机语言编号
+ (PFLanguage)language;             // 获取手机语言枚举值


// MARK: 硬件信息
+ (NSString *)resolution;           // 获取手机分辨率（宽 * 高）
+ (NSString *)systemName;           // Name of OS
+ (NSString *)nodeName;             // Name of this network node
+ (NSString *)hardwareType;         // Hardware type，形如@"iPhone11,4"
+ (NSString *)modelName;            // 型号名称（@"iPhone11,4" - iPhone XS Max）

// MARK: 网络相关

+ (NSString *)mnc;                  // 获取移动网络号码
+ (NSString *)telecomOperatorName;  // 电信运营商名称

/// 获取当前WiFi的IP地址（仅当手机连接到WiFi时候可用，否则返回为error）
+ (NSString *)ipAddressWifi;

/// 获取IP地址（VPN、WiFi、Cellular都可以获取到）
/// @param preferIPv4 是否优先IPv4
+ (NSString *)ipAddressPreferIPv4:(BOOL)preferIPv4;


#pragma mark - 手机操作

/// 打电话
/// @param phoneNumber 电话号码
+ (void)mk_call:(NSString *)phoneNumber;





#pragma mark - 网上待验证的方法

// 设备mac 地址
+ (NSString *)macAddress;
// Version
+ (NSString *)getVersion;
// SIM卡所属的运营商（公司）
+ (NSString *)serviceCompany;

+ (NSDictionary *)getDinfo;

@end

NS_ASSUME_NONNULL_END
