//
//  PFDeviceInfoTool.h
//  Test01
//
//  Created by 原鹏飞 on 2018/10/29.
//  Copyright © 2018 ypf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFDeviceInfoTool : NSObject

// 返回手机信息总览
+ (NSDictionary *)phoneInfoOverview;

// 获取手机系统版本
+ (NSString *)phoneSystemVersion;

// 获取手机型号
+ (NSString *)phoneModel;

// 获取当前剩余电量百分比
+ (float)batteryLevel;

+ (BOOL)isIphoneX;


- (void)getIphoneAllApplications;
- (void)openApp;

@end

NS_ASSUME_NONNULL_END
