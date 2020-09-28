//
//  NSDictionary+Chinese.m
//  Miku
//
//  Created by 原鹏飞 on 16/9/20.
//  Copyright © 2016年 Miku. All rights reserved.
//

#import "NSDictionary+Description.h"

@implementation NSDictionary (Description)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [strM appendString:@"}\n"];
    return strM;
}

@end
