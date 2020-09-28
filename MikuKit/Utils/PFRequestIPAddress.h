//
//  PFRequestIPAddress.h
//  Galanz+
//
//  Created by 原鹏飞 on 2019/3/10.
//  Copyright © 2019 Galanz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFRequestIPAddress : NSObject

/// 获取手机IP地址
/// @param preferIPv4 是否优先ipv4
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

@end
