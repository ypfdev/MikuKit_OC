//
//  NSArray+Chinese.m
//  AFNTestDemo
//
//  Created by wujianming on 16/9/20.
//  Copyright © 2016年 szteyou. All rights reserved.
//

#import "NSArray+Description.h"

@implementation NSArray (Description)

/// 重写数组描述方法
/// @param locale <#locale description#>
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"[\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@"]"];
    return strM;
}

@end
