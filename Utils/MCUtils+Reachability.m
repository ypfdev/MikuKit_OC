//
//  MCUtils+Reachability.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/25.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils+Reachability.h"

@implementation MCUtils (Reachability)

+ (NetworkStatus)getNetworkStatus {
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    return [reachability currentReachabilityStatus];
}

+ (void)checkNetworkStatus {
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if (status == ReachableViaWiFi) {
        // WiFi
    } else if (status == ReachableViaWWAN) {
        // 移动网络
    } else if (status == NotReachable) {
        // 无网络
    }
}


+ (void)attemptConnectWiFiWithSSID:(NSString *)ssid
                          password:(NSString *)password
                 completionHandler:(void (^ __nullable)(NSError * __nullable error))completionHandler {
    if (@available(iOS 11,*)) {
        // 创建将要连接的WiFi配置实例
        NEHotspotConfiguration *config = [[NEHotspotConfiguration alloc] initWithSSID:ssid passphrase:password isWEP:NO];
        // 开始连接 (调用此方法后系统会自动弹窗确认)
        [[NEHotspotConfigurationManager sharedManager] applyConfiguration:config completionHandler:^(NSError * _Nullable error) {
            if (completionHandler) {
                completionHandler(error);
            }
        }];
    }
}

@end
