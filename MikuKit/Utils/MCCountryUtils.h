//
//  MCCountryUtils.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/10/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCCountryItem;

@interface MCCountryUtils : NSObject

/// 获取本地时区
+ (int)localTimeZone;

// 获取时区
+ (int)timeZoneIndex:(NSTimeZone *)zone;

/// 获取默认的国家模型列表
+ (NSArray<MCCountryItem *> *)getDefaultCountryList;

/// 获取默认的国家模型
+ (MCCountryItem *)getDefaultMCCountryItem;

/// 获取默认的国家码
+ (NSString *)getDefaultCountryCode;

@end


@interface MCCountryItem : NSObject

@property (copy, nonatomic) NSString * area;
@property (copy, nonatomic) NSString * code;
@property (copy, nonatomic) NSString * name;

@property (copy, nonatomic) NSString * remark;

@end


@interface NSString (TPJSONKit)

- (id)tp_objectFromJSONString;
- (id)tp_objectFromJSONString:(NSJSONReadingOptions)serializeOptions error:(NSError **)error;

@end
