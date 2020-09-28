//
//  MCUtils+AppInfo.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/9/15.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCUtils (AppInfo)

+ (NSString *)appName;
+ (NSString *)appVersion;           // App版本号
+ (NSString *)appBuild;             // App的build版本号
+ (NSString *)bundleIdentifier;     // App唯一标识（bundle identifier）
+ (NSString *)brandID;              // bundle identifier的最后一段标记

@end

NS_ASSUME_NONNULL_END
