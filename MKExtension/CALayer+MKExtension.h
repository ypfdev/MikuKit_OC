//
//  CALayer+MKExtension.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/27.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (MKExtension)

/// 设置layer边框
/// @param color 线条颜色
/// @param width 线条宽度
- (void)mk_borderWithColor:(UIColor *)color width:(CGFloat)width;

/// 设置layer边框（仅DEBUG模式下生效）
/// @param color 线条颜色
/// @param width 线条宽度
- (void)mk_debugBorderWithColor:(UIColor *)color width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
