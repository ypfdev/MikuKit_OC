//
//  NSArray+Converter.h
//  Miku
//
//  Created by 原鹏飞 on 16/4/26.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Converter)

/// 从plist文件创建指定类型的对象数组
/// @param plistName plist文件名
/// @param className 类名
+ (NSArray *)mk_objectListWithPlistName:(NSString *)plistName
                              className:(NSString *)className;

@end
