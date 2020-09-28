//
//  NSString+Price.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/1/8.
//  Copyright © 2019 Galanz. All rights reserved.
//

#import "NSString+Price.h"

static NSNumberFormatter *formatter;

@implementation NSString (Price)

+ (void)load{
    [super load];
    if (!formatter) {
        formatter = [NSNumberFormatter new];
        formatter.minimumFractionDigits = 0;    //最低小数位数
        formatter.maximumFractionDigits = 2;    //最高小数位数
        formatter.minimumIntegerDigits = 1;     //最低整数位数
    }
}


+ (NSString *)mk_rmbPriceStringWithPrice:(CGFloat)price {
    return [NSString stringWithFormat:@"¥%@",[formatter stringFromNumber:@(price)]];
//    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
//
//    NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithDouble:price];
//    NSDecimalNumber *roundedNum = [num decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
//
//    return [NSString stringWithFormat:@"￥%@", roundedNum];
}


+ (NSString *)mk_priceStringWithPrice:(CGFloat)price {
    return [NSString stringWithFormat:@"%@",[formatter stringFromNumber:@(price)]];
//    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
//
//    NSDecimalNumber *num = [[NSDecimalNumber alloc] initWithDouble:price];
//    NSDecimalNumber *roundedNum = [num decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
//
//    return [NSString stringWithFormat:@"%@", roundedNum];
}


+ (NSString *)mk_priceStringWithPrice:(CGFloat)price length:(NSInteger)length {
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:length raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}


/// 处理价格的方法（千分位五舍六入，且不去零）
/// @param price 浮点数价格
- (NSString *)convernPrice:(CGFloat)price {
    return [NSString stringWithFormat:@"¥%@",[formatter stringFromNumber:@(price)]];
}

@end
