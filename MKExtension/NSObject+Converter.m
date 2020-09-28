//
//  NSObject+Converter.m
//  Miku
//
//  Created by 原鹏飞 on 16/4/26.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import "NSObject+Converter.h"

@implementation NSObject (Converter)

/// 使用字典创建模型对象
///
/// @param dict 字典
///
/// @return 模型对象
+ (instancetype)mk_objectWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

+ (instancetype)mk_objectWithPlistName:(NSString *)plistName {
    // 从plist文件中读取模型
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    PFLog(@"infoDict = %@", infoDict);
    return [self mj_objectWithKeyValues:infoDict];
//    PFLog(@"deviceModel = %@", deviceModel);
//    PFLog(@"name = %@, defaultValue = %@", deviceModel.workmodes.firstObject, deviceModel.workmodes.firstObject.parameters.firstObject.defaultValue);
}

/**
 获取对象的所有属性数组

 @return 属性数组
 */
- (NSArray *)mk_arrayWithAllProperty {
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        const char *propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}


/**
 模型转字典

 @return 字典
 */
- (NSDictionary *)mk_dictWithAllProperty {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}


@end
