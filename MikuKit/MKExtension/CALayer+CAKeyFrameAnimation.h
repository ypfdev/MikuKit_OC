//
//  CALayer+CAKeyFrameAnimation.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/27.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (CAKeyFrameAnimation)

/// 往复运动（x轴）
/// @param amplitude 幅度
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_xRockAnimationWithAmplitude:(CGFloat)amplitude
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount;

/// 往复运动（y轴）
/// @param amplitude 幅度
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_yRockAnimationWithAmplitude:(CGFloat)amplitude
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount;

/// 往复运动（z轴）
/// @param amplitude 幅度
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_zRockAnimationWithAmplitude:(CGFloat)amplitude
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount;

/// 圆周运动（x轴）
/// @param radius 轨道半径
/// @param duration 单周
/// @param repeatCount 重复次数
- (void)mk_circularAnimationWithRadius:(CGFloat)radius
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount;

@end

NS_ASSUME_NONNULL_END
