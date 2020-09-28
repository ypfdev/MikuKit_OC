//
//  NSString+Price.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/1/8.
//  Copyright © 2019 Galanz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Price)

/// 浮点数价格转人民币价格字符串（最多保留2位非零小数）
/// @param price 浮点数价格
+ (NSString *)mk_rmbPriceStringWithPrice:(CGFloat)price;

/// 浮点数价格转价格字符串（最多保留2位非零小数）
/// @param price 浮点数价格
+ (NSString *)mk_priceStringWithPrice:(CGFloat)price;

/// 浮点数价格转价格字符串（最多保留2位非零小数）
/// @param price 浮点数价格
/// @param length 小数位数
+ (NSString *)mk_priceStringWithPrice:(CGFloat)price length:(NSInteger)length;

@end

NS_ASSUME_NONNULL_END
