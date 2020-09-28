//
//  MCUtils+AppInfo.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/9/15.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils+AppInfo.h"

@implementation MCUtils (AppInfo)

+ (NSString *)appName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuild {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

+ (NSString *)bundleIdentifier {
    return [[NSBundle mainBundle] bundleIdentifier];
    
//    // 或者通过[[NSBundle mainBundle] infoDictionary]拿
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    return [infoDictionary objectForKey:@"CFBundleIdentifier"];
}

+ (NSString *)brandID {
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *array = [identifier componentsSeparatedByString:@"."];
    return array.lastObject;
}

@end
