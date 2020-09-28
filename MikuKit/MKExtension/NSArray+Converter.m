//
//  NSArray+Converter.m
//  Miku
//
//  Created by 原鹏飞 on 16/4/26.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import "NSArray+Converter.h"
#import "NSObject+Converter.h"

@implementation NSArray (Converter)

+ (NSArray *)mk_objectListWithPlistName:(NSString *)plistName
                              className:(NSString *)className {
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    NSArray *list = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    Class cls = NSClassFromString(className);
    NSAssert(cls, @"加载 plist 文件时指定的 clsName - %@ 错误", className);
    
    for (NSDictionary *dict in list) {
        [arrayM addObject:[cls mk_objectWithDict:dict]];
    }
    
    return arrayM.copy;
}

@end
