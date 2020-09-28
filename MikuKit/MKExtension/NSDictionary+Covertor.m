//
//  NSDictionary+Covertor.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2018/11/29.
//  Copyright © 2018 Galanz. All rights reserved.
//

#import "NSDictionary+Covertor.h"

@implementation NSDictionary (Covertor)

+ (NSDictionary *)mk_dictionaryWithJsonString:(NSString *)jsonStr {
    if (jsonStr == nil) {
        PFLog(@"传入的json字符串为空");
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        PFLog(@"json解析失败：%@", error);
        return nil;
    }
    return dic;
}

@end
