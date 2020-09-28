//
//  MCUtils+Converter.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/7/7.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils+Converter.h"

@implementation MCUtils (Converter)

+ (NSDictionary *)mk_dictFromJsonStr:(NSString *)jsonStr {
    if (jsonStr == nil) {
        NSLog(@"传入的json字符串为空");
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@", error);
        return @{};
    }
    return dic;
}

/// CGFloat转NSInteger
/// @param fValue 单精度浮点数
/// @param approximateType 近似运算类型
- (NSInteger)mk_convertToIntegerFromFloat:(CGFloat)fValue
                          approximateType:(MKApproximateType)approximateType {
    // 相关函数都在“iOSxx/usr\/include/math.h”中
    switch (approximateType) {
        case MKApproximateTypeRounding:
            return (NSInteger)roundf(fValue);
            break;
        case MKApproximateTypeRoundedUp:
            return (NSInteger)ceilf(fValue);
            break;
        case MKApproximateTypeRoundedDown:
            return (NSInteger)floorf(fValue);
            break;
            
        default:
            return (NSInteger)roundf(fValue);
            break;
    }
}



@end
