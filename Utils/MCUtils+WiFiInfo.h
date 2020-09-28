//
//  MCUtils+WiFiInfo.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/25.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCUtils (WiFiInfo)

/// WLAN状态（即手机WiFi开关状态。注意！当开关打开但未连接任何热点时，也返回YES）
+ (BOOL)wifi_WLANStatus;

+ (NSString *)getWiFiMacAddress;

+ (NSString *)getWiFiSSID;

//获取wifi ssid名称
+ (NSString *)getWifiName;

//获取连接设备Mac地址
+ (NSString*) getMacAddress;

//获取广播地址
+ (NSString* )getBroadCastAddress;

// 获取网关地址
+ (NSString *)getHostIP;

@end

NS_ASSUME_NONNULL_END
