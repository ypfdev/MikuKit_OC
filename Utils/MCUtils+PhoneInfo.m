//
//  MCUtils+PhoneInfo.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/9/18.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils+PhoneInfo.h"

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/utsname.h>         // 获取手机型号
#import "PFRequestIPAddress.h"  // 获取IP

// 网上待验证的
// ****************************************
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/stat.h> //真机必须导入这个头文件

/*
 * Top-level identifiers
 */
#define CTL_NET     4       /* network, see socket.h */
#define AF_ROUTE    17      /* Internal Routing Protocol */
#define AF_LINK     18      /* Link layer interface */
#define NET_RT_IFLIST2      6   /* interface list with addresses */
#define NET_RT_IFLIST       3   /* survey interface list */

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

//获取屏幕宽度
#define screenWide [UIScreen mainScreen].bounds.size.width
//获取屏幕高度
#define screenHeight [UIScreen mainScreen].bounds.size.height
// ****************************************

@implementation MCUtils (PhoneInfo)

+ (NSString *)uuid {
    if (@available(iOS 13.0,*)) {
        // iOS5之后，苹果封闭了获取UUID的API，现在拿到的并不是手机真正的UUID，但也是一个唯一的字符串，可以当做设备唯一标识用
        
        
        
        NSUUID *uuid = [UIDevice currentDevice].identifierForVendor;    // API_AVAILABLE(ios(6.0))  // a UUID that may be used to uniquely identify the device, same across apps from a single vendor.
        NSString *uuidStr = [uuid UUIDString];
        return uuidStr;
    } else {
        CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
        NSString *cfuuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
        CFRelease(cfuuid);
        return cfuuidStr;
    }
}


+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)resolution {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat width = scale * size.width;
    CGFloat height = scale * size.height;
    return [NSString stringWithFormat:@"%d*%d", (int)width, (int)height];
}

+ (NSString *)mnc {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    if (carrier == nil) {
        return nil;
    }
    // 获取MCC(移动国家码)
    NSString *mcc = [carrier mobileCountryCode];
    // 获取MNC(移动网络码)
    NSString *mnc = [carrier mobileNetworkCode];
    if (mcc.length <= 2) {// || mnc.length <= 2
        return nil;
    }
    // 判断运营商
    if ([[mcc substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"460"]) {
        return mnc;
    }
    return nil;
}

+ (NSString *)preferredLanguage {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [userDef objectForKey:@"AppleLanguages"];
    /* 语言举例
     @"zh-Hans-CN"：简体中文
     @"zh-Hant-CN"：繁体中文
     @"zh-Hant-HK"：繁体中文（香港）
     @“en-CN”：English
     @“en-US”：English (US)
     @"en-GB": English (UK)
     @“ja-CN”：日语
     */
    return languages.firstObject;   // 数组中的第0个元素就是系统当前语言
}

+ (NSString *)languageCode {
    /* 语言代码
     @"zh-Hans"/@"zh-Hans-CN"：中文（简体）
     @"zh-Hant"/@"zh-Hant-CN"：中文（繁体）
     @"en"：英
     @"fr"：法语
     @"de"：德语
     @"es"：西班牙语
     @"it"：意大利语
     @"ja"：日语
     */
    // 获取语言&地区代码，形如@"es-CN"
    NSString *languageAndRegion = [NSLocale preferredLanguages].firstObject;
    return [languageAndRegion componentsSeparatedByString:@"-"].firstObject;
}

+ (PFLanguage)language {
    NSString *languageCode = [NSLocale preferredLanguages].firstObject;
    if ([languageCode isEqualToString:@"zh-Hans"] ||
        [languageCode isEqualToString:@"zh-Hans-CN"]) {
        return PFLanguageSimplifiedChinese;
    } else if ([languageCode isEqualToString:@"zh-Hant"] ||
               [languageCode isEqualToString:@"zh-Hant-CN"]) {
        return PFLanguageTraditionalChinese;
    } else if ([languageCode isEqualToString:@"en"]) {
        return PFLanguageEnglish;
    } else if ([languageCode isEqualToString:@"fr"]) {
        return PFLanguageFrench;
    } else if ([languageCode isEqualToString:@"de"]) {
        return PFLanguageGerman;
    } else if ([languageCode isEqualToString:@"es"]) {
        return PFLanguageSpanish;
    } else if ([languageCode isEqualToString:@"pt-PT"]) {
        return PFLanguagePortuguese;
    } else if ([languageCode isEqualToString:@"it"]) {
        return PFLanguageItalian;
    } else if ([languageCode isEqualToString:@"ja"]) {
        return PFLanguageJapanese;
    } else if ([languageCode isEqualToString:@"ko"]) {
        return PFLanguageKorean;
    } else {
        return PFLanguageSimplifiedChinese;
    }
}

+ (NSString *)telecomOperatorName {
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    /** carrier打印结果
     CTCarrier (0x28014f0f0) {
     Carrier name: [中国电信]
     Mobile Country Code: [460]
     Mobile Network Code:[11]
     ISO Country Code:[cn]
     Allows VOIP? [YES]
     }
     */
    // 先判断有没有安装SIM卡, 如果没有, 此时carrierName为手机的默认运营商名称（例如电信版手机为中国电信）
    if (carrier.isoCountryCode) {
        return @"无SIM卡（无运营商）";
    }
    return [carrier carrierName];
}

+ (NSString *)systemName {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.sysname encoding:NSASCIIStringEncoding];
}

+ (NSString *)nodeName {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.nodename encoding:NSASCIIStringEncoding];
}

+ (NSString *)hardwareType {
    // 方法1
    struct utsname systemInfo;
    uname(&systemInfo);
    // 取出Hardware type字符串
    NSString *harewareType = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    return harewareType;
    
//    // 方法2
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *model = malloc(size);
//    sysctlbyname("hw.machine", model, &size, NULL, 0);
//    NSString *harewareType = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
//    free(model);
//    return harewareType;
}

+ (NSString *)modelName {
    struct utsname systemInfo;
    uname(&systemInfo);
    // 官方支持-识别苹果设备的机型 https://www.apple.com.cn/search/识别?src=globalnav
    // 齐全的苹果机型信息表 https://www.theiphonewiki.com/wiki/Models
    
    // 取出Hardware type字符串，据此得到对应的型号名称
    NSString *hardwareType = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    // MARK: iPhone
    if ([hardwareType containsString:@"iPhone"]) {
        if ([hardwareType isEqualToString:@"iPhone1,1"])    return @"iPhone";                       // A1203
        if ([hardwareType isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";                    // A1241, A1324(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";                   // A1303, A1325(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone3,1"])    return @"iPhone 4";                     // A1332
        if ([hardwareType isEqualToString:@"iPhone3,2"])    return @"iPhone 4";                     // A1332
        if ([hardwareType isEqualToString:@"iPhone3,3"])    return @"iPhone 4";                     // A1349
        if ([hardwareType isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";                    // A1387, A1431(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone5,1"])    return @"iPhone 5";                     // A1428
        if ([hardwareType isEqualToString:@"iPhone5,2"])    return @"iPhone 5";                     // A1429, A1442(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";                    // A1456, A1532
        if ([hardwareType isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";                    // A1507, A1516(China-exclusive model), A1526, A1529
        if ([hardwareType isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";              // A1453, A1533
        if ([hardwareType isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";         // A1457, A1518(China-exclusive model), A1528(China-exclusive model), A1530
        if ([hardwareType isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";                // A1522, A1524, A1593(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone7,2"])    return @"iPhone 6";                     // A1549, A1586, A1589(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";                    // A1633, A1688, A1691(China-exclusive model), A1700(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";               // A1634, A1687, A1690(China-exclusive model), A1699(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone8,4"])    return @"iPhone SE";                    // A1662, A1723, A1724(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone9,1"])    return @"iPhone 7";                     // A1660, A1779(日行独占Apple Pay版(兼容索尼FeliCa)), A1780
        if ([hardwareType isEqualToString:@"iPhone9,3"])    return @"iPhone 7";                     // A1778
        if ([hardwareType isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";                // A1661, A1785(日行独占Apple Pay版(兼容索尼FeliCa)), A1786
        if ([hardwareType isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";                // A1784
        if ([hardwareType isEqualToString:@"iPhone10,1"])   return @"iPhone 8";                     // A1863, A1906(Japan-exclusive model), A1907
        if ([hardwareType isEqualToString:@"iPhone10,4"])   return @"iPhone 8";                     // A1905
        if ([hardwareType isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";                // A1864, A1898(Japan-exclusive model), A1899
        if ([hardwareType isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";                // A1897
        if ([hardwareType isEqualToString:@"iPhone10,3"])   return @"iPhone X";                     // A1865, A1902(Japan-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone10,6"])   return @"iPhone X";                     // A1901
        if ([hardwareType isEqualToString:@"iPhone11,2"])   return @"iPhone XS";                    // A1920, A2097, A2098(Japan-exclusive model), A2100(China-exclusive model)
        if ([hardwareType isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";                // ?
        if ([hardwareType isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";                // A1921, A2101, A2102(Japan-exclusive model), A2104(国行独占双卡版)
        if ([hardwareType isEqualToString:@"iPhone11,8"])   return @"iPhone XR";                    // A1984, A2105, A2106(Japan-exclusive model), A2108(国行独占双卡版)
        if ([hardwareType isEqualToString:@"iPhone12,1"])   return @"iPhone 11";                    // A2111, A2221, A2223(国行独占双卡版)
        if ([hardwareType isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";                // A2160, A2215, A2217(国行独占双卡版)
        if ([hardwareType isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";            // A2161, A2220, A2218(国行独占双卡版)
        if ([hardwareType isEqualToString:@"iPhone12,8"])   return @"iPhone SE 2";                  // ?
    } else if ([hardwareType containsString:@"iPad"]) {
        // MARK: iPad
        if ([hardwareType isEqualToString:@"iPad1,1"])      return @"iPad";                         // A1219, A1337
        if ([hardwareType isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";                // A1395
        if ([hardwareType isEqualToString:@"iPad2,2"])      return @"iPad 2";                       // A1396
        if ([hardwareType isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";                // A1397
        if ([hardwareType isEqualToString:@"iPad2,4"])      return @"iPad 2";                       // A1395
        if ([hardwareType isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";             // A1432
        if ([hardwareType isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";              // A1454
        if ([hardwareType isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";         // A1455
        if ([hardwareType isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";                // A1416
        if ([hardwareType isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";            // A1403
        if ([hardwareType isEqualToString:@"iPad3,3"])      return @"iPad 3";                       // A1430
        if ([hardwareType isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";                // A1458
        if ([hardwareType isEqualToString:@"iPad3,5"])      return @"iPad 4";                       // A1459
        if ([hardwareType isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";            // A1460
        if ([hardwareType isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";              // A1474
        if ([hardwareType isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";          // A1475
        if ([hardwareType isEqualToString:@"iPad4,3"])      return @"iPad Air (Cellular)";          // A1476
        if ([hardwareType isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";           // A1489
        if ([hardwareType isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";       // A1490
        if ([hardwareType isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";                  // A1491
        if ([hardwareType isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";                  // A1599
        if ([hardwareType isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";                  // A1600
        if ([hardwareType isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";                  // A1601
        if ([hardwareType isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";           // A1538
        if ([hardwareType isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";       // A1550
        if ([hardwareType isEqualToString:@"iPad5,3"])      return @"iPad Air 2";                   // A1566
        if ([hardwareType isEqualToString:@"iPad5,4"])      return @"iPad Air 2";                   // A1567
        if ([hardwareType isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch";            // A1673
        if ([hardwareType isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch";            // A1674, A1675
        if ([hardwareType isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch";           // A1584
        if ([hardwareType isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch";           // A1652
        if ([hardwareType isEqualToString:@"iPad6,11"])     return @"iPad 5";                       // A1822
        if ([hardwareType isEqualToString:@"iPad6,12"])     return @"iPad 5";                       // A1823
        if ([hardwareType isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9-inch 2nd gen";   // A1670
        if ([hardwareType isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9-inch 2nd gen";   // A1671, A1821
        if ([hardwareType isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5-inch";           // A1701
        if ([hardwareType isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5-inch";           // A1709
        if ([hardwareType isEqualToString:@"iPad7,5"])      return @"iPad 6";                       // A1893
        if ([hardwareType isEqualToString:@"iPad7,6"])      return @"iPad 6";                       // A1954
        if ([hardwareType isEqualToString:@"iPad7,11"])     return @"iPad 7";                       // A2197
        if ([hardwareType isEqualToString:@"iPad7,12"])     return @"iPad 7";                       // A2198, A2200
        if ([hardwareType isEqualToString:@"iPad8,1"])      return @"iPad Pro 11-inch";             // A1980
        if ([hardwareType isEqualToString:@"iPad8,2"])      return @"iPad Pro 11-inch";             // A1980
        if ([hardwareType isEqualToString:@"iPad8,3"])      return @"iPad Pro 11-inch";             // A1934, A1979(Japan-exclusive model), A2013
        if ([hardwareType isEqualToString:@"iPad8,4"])      return @"iPad Pro 11-inch";             // A1934, A1979(Japan-exclusive model), A2013
        if ([hardwareType isEqualToString:@"iPad8,5"])      return @"iPad Pro 12.9-inch 3rd gen";   // A1876
        if ([hardwareType isEqualToString:@"iPad8,6"])      return @"iPad Pro 12.9-inch 3rd gen";   // A1876
        if ([hardwareType isEqualToString:@"iPad8,7"])      return @"iPad Pro 12.9-inch 3rd gen";   // A1895, A1983(Japan-exclusive model), A2014
        if ([hardwareType isEqualToString:@"iPad8,8"])      return @"iPad Pro 12.9-inch 3rd gen";   // A1895, A1983(Japan-exclusive model), A2014
        if ([hardwareType isEqualToString:@"iPad8,9"])      return @"iPad Pro 11-inch 2nd gen";     // ?
        if ([hardwareType isEqualToString:@"iPad8,10"])     return @"iPad Pro 11-inch 2nd gen";     // ?
        if ([hardwareType isEqualToString:@"iPad8,11"])     return @"iPad Pro 12.9-inch 4th gen";   // ?
        if ([hardwareType isEqualToString:@"iPad8,12"])     return @"iPad Pro 12.9-inch 4th gen";   // ?
        if ([hardwareType isEqualToString:@"iPad11,1"])     return @"iPad mini 5";                  // A2133
        if ([hardwareType isEqualToString:@"iPad11,2"])     return @"iPad mini 5";                  // A2124, A2125, A2126
        if ([hardwareType isEqualToString:@"iPad11,3"])     return @"iPad Air 3";                   // A2152
        if ([hardwareType isEqualToString:@"iPad11,4"])     return @"iPad Air 3";                   // A2123, A2153, A2154
    } else if ([hardwareType containsString:@"iPod"]) {
        // MARK: iPod
        if ([hardwareType isEqualToString:@"iPod1,1"])      return @"iPod Touch";                   // A1213
        if ([hardwareType isEqualToString:@"iPod2,1"])      return @"iPod Touch 2";                 // A1288, A1319(Japan-exclusive model)
        if ([hardwareType isEqualToString:@"iPod3,1"])      return @"iPod Touch 3";                 // A1318
        if ([hardwareType isEqualToString:@"iPod4,1"])      return @"iPod Touch 4";                 // A1367
        if ([hardwareType isEqualToString:@"iPod5,1"])      return @"iPod Touch 5";                 // A1421, A1509
        if ([hardwareType isEqualToString:@"iPod7,1"])      return @"iPod Touch 6";                 // A1574
        if ([hardwareType isEqualToString:@"iPod9,1"])      return @"iPod Touch 7";                 // A2178
    } else if ([hardwareType containsString:@"Watch"]) {
        if ([hardwareType isEqualToString:@"Watch1,1"])     return @"Apple Watch";                  // A1553
        if ([hardwareType isEqualToString:@"Watch1,2"])     return @"Apple Watch";                  // A1554, A1638
        if ([hardwareType isEqualToString:@"Watch2,6"])     return @"Apple Watch Series 1";         // A1802, A1803
        if ([hardwareType isEqualToString:@"Watch2,7"])     return @"Apple Watch Series 1";         // A1553
        if ([hardwareType isEqualToString:@"Watch2,3"])     return @"Apple Watch Series 2";         // A1757, A1816
        if ([hardwareType isEqualToString:@"Watch2,4"])     return @"Apple Watch Series 2";         // A1758, A1817
        if ([hardwareType isEqualToString:@"Watch3,1"])     return @"Apple Watch Series 3";         // A1860, A1889, A1890
        if ([hardwareType isEqualToString:@"Watch3,2"])     return @"Apple Watch Series 3";         // A1861, A1891, A1892
        if ([hardwareType isEqualToString:@"Watch3,3"])     return @"Apple Watch Series 3";         // A1858
        if ([hardwareType isEqualToString:@"Watch3,4"])     return @"Apple Watch Series 3";         // A1859
        if ([hardwareType isEqualToString:@"Watch4,1"])     return @"Apple Watch Series 4";         // A1977
        if ([hardwareType isEqualToString:@"Watch4,2"])     return @"Apple Watch Series 4";         // A1978
        if ([hardwareType isEqualToString:@"Watch4,3"])     return @"Apple Watch Series 4";         // A1975, A2007
        if ([hardwareType isEqualToString:@"Watch4,4"])     return @"Apple Watch Series 4";         // A1976, A2008
        if ([hardwareType isEqualToString:@"Watch5,1"])     return @"Apple Watch Series 5";         // A2092
        if ([hardwareType isEqualToString:@"Watch5,2"])     return @"Apple Watch Series 5";         // A2093
        if ([hardwareType isEqualToString:@"Watch5,3"])     return @"Apple Watch Series 5";         // A2094, A2156
        if ([hardwareType isEqualToString:@"Watch5,4"])     return @"Apple Watch Series 5";         // A2095, A2157
    } else if ([hardwareType containsString:@"Pods"]) {
        if ([hardwareType isEqualToString:@"AirPods1,1"])   return @"AirPods";                      // A1523(R), A1722(L), A1602(charging case)
        if ([hardwareType isEqualToString:@"AirPods2,1"])   return @"AirPods 2";                    // A2031(L), A2032(R), A1938(wireless charging case)
        if ([hardwareType isEqualToString:@"iProd8,1"])     return @"AirPods Pro";                  // A2083(L), A2084(R), A2190(AirPods Pro charging case)
    } else if ([hardwareType containsString:@"AppleTV"]) {
        // MARK: Apple TV
        if ([hardwareType isEqualToString:@"AppleTV1,1"])   return @"Apple TV";                     // A1218
        if ([hardwareType isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2";                   // A1378
        if ([hardwareType isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";                   // A1427
        if ([hardwareType isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3";                   // A1469
        if ([hardwareType isEqualToString:@"AppleTV5,3"])   return @"Apple TV 4";                   // A1625
        if ([hardwareType isEqualToString:@"AppleTV6,2"])   return @"Apple TV 4K";                  // A1842
    } else if ([hardwareType containsString:@"AudioAccessory"]) {
        if ([hardwareType isEqualToString:@"AudioAccessory1,1"])    return @"HomePod";              // A1639
        if ([hardwareType isEqualToString:@"AudioAccessory1,2"])    return @"HomePod";              // ?
    } else {
        // MARK: Simulator
        if ([hardwareType isEqualToString:@"i386"])         return @"Simulator";
        if ([hardwareType isEqualToString:@"x86_64"])       return @"Simulator";
    }
    
    return hardwareType;
}

+ (NSString *)ipAddressWifi {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)ipAddressPreferIPv4:(BOOL)preferIPv4 {
    return [PFRequestIPAddress getIPAddress:preferIPv4];
}


#pragma mark - 手机操作

/// 打电话
/// @param phoneNumber 电话号码
+ (void)mk_call:(NSString *)phoneNumber {
    if ([MCUtils mk_validateEmpytOrNullRemindString:phoneNumber trim:YES]) {
        [MCTipsUtils showTips:@"号码为空"];
        return;
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
    if (@available(iOS 10.0,*)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}


#pragma mark - 网上待验证的

/// 获取设备MAC地址
+ (NSString *)macAddress {
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = (char*)malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    PFLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}

//- (NSString *)getWifiSsid {
//    if (@available(iOS 13.0, *)) {
//        //用户明确拒绝，可以弹窗提示用户到设置中手动打开权限
//        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//            PFLog(@"User has explicitly denied authorization for this application, or location services are disabled in Settings.");
//            //使用下面接口可以打开当前应用的设置页面
//            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//            return nil;
//        }
//        CLLocationManager* cllocation = [[CLLocationManager alloc] init];
//        if(![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
//            //弹框提示用户是否开启位置权限
//            [cllocation requestWhenInUseAuthorization];
//            usleep(50);
//            //递归等待用户选选择
//            return [self getWifiSsidWithCallback:callback];
//        }
//    }
//    NSString *wifiName = nil;
//    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
//    if (!wifiInterfaces) {
//        return nil;
//    }
//    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
//    for (NSString *interfaceName in interfaces) {
//        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
//
//        if (dictRef) {
//            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
//            PFLog(@"network info -> %@", networkInfo);
//            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
//            CFRelease(dictRef);
//        }
//    }
//
//    CFRelease(wifiInterfaces);
//    return wifiName;
//}


// Version
+ (NSString *)getVersion {
    
    NSString *string = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:string];
    NSString *version = [dic objectForKey:@"CFBundleVersion"];
    return version;
    
}



///SIM卡所属的运营商（公司）
+ (NSString *)serviceCompany {
    NSArray *infoArray = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    for (id info in infoArray) {
        if ([info isKindOfClass:NSClassFromString(@"UIStatusBarServiceItemView")]) {
            NSString *serviceString = [info valueForKeyPath:@"serviceString"];
            PFLog(@"公司为：%@",serviceString);
            return serviceString;
        }
    }
    return @"";
}


+ (NSDictionary *)getDinfo {
    NSString *mac = [self macAddress];
    NSString *udid = [self uuid];
    NSString *ip = [self ipAddressIsV4:YES];
    NSString *p =  [self getDeviceInfo];
    NSString *jb = [NSString stringWithFormat:@"%i",[self jailbroken]];
    NSString *rw = [NSString stringWithFormat:@"%f",screenWide];
    NSString *rh = [NSString stringWithFormat:@"%f",screenHeight];
    NSString *o = [self chinaMobileModel];
    NSString *m = [self modelName];
    NSString *osv = [self getSystemVersion];
    NSString *cv = [NSString stringWithFormat:@"%ld",[self version]];
    NSString *n = [self getNetWorkStates];
    
    NSDictionary *dinfo = @{
        @"os":@"i",
        @"osv": osv,
        @"osvc":@"17",
        @"udid": udid,
        @"ip":ip,
        @"p":p,
        @"jb":jb,
        @"rw":rw,
        @"rh":rh,
        @"o":o,
        @"m":m,
        @"cv":cv,
        @"cvc":@"14",
        @"mac": mac,
        @"n":n,
        @"phone":@"",
        @"imsi":@"",
        @"imei":@""
    };
    return dinfo;
}

//  判断当前网络连接状态
+ (NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            PFLog(@"netType:%d",netType);
            switch (netType) {
                case 0:
                    //                    state = @"无网络"; // 5
                    state = @"5";
                    //无网模式
                    break;
                case 1:
                    //                    state = @"2G"; // 1
                    state = @"1";
                    break;
                case 2:
                    //                    state = @"3G"; // 2
                    state = @"3";
                    break;
                case 3:
                    //                    state = @"4G"; //3
                    state = @"4";
                    break;
                case 5:
                    //                    state = @"WIFI"; //5
                    state = @"5";
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}


+ (NSString *)getSystemVersion {
    UIDevice *device = [[UIDevice alloc] init];
    NSString *systemVersion = device.systemVersion;
    return systemVersion;
}


// ip 地址
+ (NSString *)ipAddressIsV4:(BOOL)v4
{
    NSArray *searchArray = v4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self addressInfo];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
        address = addresses[key];
        if(address) *stop = YES;
    } ];
    return address ? address : @"0.0.0.0";
}

// 设备信息 产品名称
+ (NSString *)getDeviceInfo {
    UIDevice *device = [[UIDevice alloc] init];
    NSString *name = device.name;       //获取设备所有者的名称
    NSString *model = device.name;      //获取设备的类别
    NSString *type = device.localizedModel; //获取本地化版本
    NSString *systemName = device.systemName;   //获取当前运行的系统
    NSString *systemVersion = device.systemVersion;//获取当前系统的版本
    PFLog(@"-----name : %@,model : %@,type : %@,systemName :%@,systemVersion %@",name,model,type,systemName,systemVersion);
    return model;
}

// 是否越狱
+ (BOOL)jailbroken
{
#if !TARGET_IPHONE_SIMULATOR
    
    //Apps and System check list
    BOOL isDirectory;
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"bla", @"ckra1n.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Fake", @"Carrier.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Ic", @"y.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Inte", @"lliScreen.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"MxT", @"ube.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Roc", @"kApp.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"SBSet", @"ttings.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Wint", @"erBoard.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/a", @"pt/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/c", @"ydia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/mobile", @"Library/SBSettings", @"Themes/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/t", @"mp/cyd", @"ia.log"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/s", @"tash/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/b",@"in", @"s", @"shd"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/sb",@"in", @"s", @"shd"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/sftp-", @"server"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@",@"/Syste",@"tem/Lib",@"rary/Lau",@"nchDae",@"mons/com.ike",@"y.bbot.plist"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@%@",@"/Sy",@"stem/Lib",@"rary/Laun",@"chDae",@"mons/com.saur",@"ik.Cy",@"@dia.Star",@"tup.plist"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/Libr",@"ary/Mo",@"bileSubstra",@"te/MobileSubs",@"trate.dylib"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/va",@"r/c",@"ach",@"e/a",@"pt/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib",@"/apt/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib/c",@"ydia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"og/s",@"yslog"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/bi",@"n/b",@"ash"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/b",@"in/",@"sh"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/et",@"c/a",@"pt/"]isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/etc/s",@"sh/s",@"shd_config"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/us",@"r/li",@"bexe",@"c/ssh-k",@"eysign"]])
        
    {
        return YES;
    }
    
    // SandBox Integrity Check
    int pid = fork(); //返回值：子进程返回0，父进程中返回子进程ID，出错则返回-1
    if(!pid){
        exit(0);
    }
    if(pid>=0)
    {
        return YES;
    }
    
    //Symbolic link verification
    struct stat s;
    if(lstat("/Applications", &s) || lstat("/var/stash/Library/Ringtones", &s) || lstat("/var/stash/Library/Wallpaper", &s)
       || lstat("/var/stash/usr/include", &s) || lstat("/var/stash/usr/libexec", &s)  || lstat("/var/stash/usr/share", &s)
       || lstat("/var/stash/usr/arm-apple-darwin9", &s))
    {
        if(s.st_mode & S_IFLNK){
            return YES;
        }
    }
    
    //Try to write file in private
    NSError *error;
    [[NSString stringWithFormat:@"Jailbreak test string"] writeToFile:@"/private/test_jb.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if(nil==error){
        //Writed
        return YES;
    } else {
        [defaultManager removeItemAtPath:@"/private/test_jb.txt" error:nil];
    }
    
#endif
    return NO;
}


+ (NSDictionary *)addressInfo {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

// 运营商
+ (NSString *)chinaMobileModel
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        //        return @"不识别";
        return @"0";
    }
    
    NSString *code = [carrier mobileNetworkCode];
    if (code == nil) {
        //        return @"不识别";
        return @"0";
    }
    
    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"])
    {
        //        return @"移动";
        return @"1";
    }else if ([code isEqualToString:@"01"] || [code isEqualToString:@"06"])
    {
        //        return @"联通";
        return @"2";
    }else if ([code isEqualToString:@"03"] || [code isEqualToString:@"05"])
    {
        //        return @"电信";
        return @"3";
    }else if ([code isEqualToString:@"20"])
    {
        return @"铁通";
    }
    return @"不识别";
}


#pragma mark - 废弃方法

/// 获取WiFi信号强度（UIStatusBar相关API被禁用了，现在调用这个方法会crash（2019.8.31））
+ (NSInteger)getWifiSignalStrength {
    UIApplication *app = [UIApplication sharedApplication];
    // UIStatusBar相关API被禁用了，通过KVO获取statusBar会crash（2019.8.31）
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSString *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    NSInteger signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] integerValue];
    return signalStrength;
}



@end
