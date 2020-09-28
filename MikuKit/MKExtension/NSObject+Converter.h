//
//  NSObject+Converter.h
//  Miku
//
//  Created by 原鹏飞 on 16/4/26.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Converter)

/// 使用字典创建模型对象
///
/// @param dict 字典
///
/// @return 模型对象
+ (instancetype)mk_objectWithDict:(NSDictionary *)dict;


/// 从plist文件读取模型（默认搜索mainBundle下的plist文件）
/// @param plistName plist文件名
+ (instancetype)mk_objectWithPlistName:(NSString *)plistName;

/**
 获取对象的所有属性数组
 
 @return 属性数组
 */
- (NSArray *)mk_arrayWithAllProperty;


/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)mk_dictWithAllProperty;

@end
