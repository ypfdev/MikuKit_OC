//
//  MCUtils+Converter.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/7/7.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MKApproximateTypeRounding,      // 四舍五入
    MKApproximateTypeRoundedUp,     // 向上取整
    MKApproximateTypeRoundedDown,   // 向下取整
} MKApproximateType;

@interface MCUtils (Converter)

/// json字符串转字典
/// @param jsonStr 待处理的json字符串
+ (NSDictionary *)mk_dictFromJsonStr:(NSString *)jsonStr;

/// CGFloat转NSInteger
/// @param fValue 单精度浮点数
/// @param approximateType 近似运算类型
- (NSInteger)mk_convertToIntegerFromFloat:(CGFloat)fValue
                          approximateType:(MKApproximateType)approximateType;

@end

NS_ASSUME_NONNULL_END
