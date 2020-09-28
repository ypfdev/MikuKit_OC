//
//  MCUtils+Reachability.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/25.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils.h"
#import "Reachability.h"    // 原生网络监听
#import <NetworkExtension/NEHotspotConfigurationManager.h>  // 根据SSID和密码连接到已知WIFI

NS_ASSUME_NONNULL_BEGIN

@interface MCUtils (Reachability)

/// 获取当前网络状态
+ (NetworkStatus)getNetworkStatus;

/// 检查当前网络可用性
+ (void)checkNetworkStatus;

/// 尝试根据SSID和密码连接到WIFI（>=iOS11）
/// @param ssid 热点SSID
/// @param password 热点密码
+ (void)attemptConnectWiFiWithSSID:(NSString *)ssid
                          password:(NSString *)password
                 completionHandler:(void (^ __nullable)(NSError * __nullable error))completionHandler API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(macos, watchos, tvos);

@end

NS_ASSUME_NONNULL_END
