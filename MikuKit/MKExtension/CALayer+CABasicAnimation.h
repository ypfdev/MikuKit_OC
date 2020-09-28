//
//  CALayer+CABasicAnimation.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/27.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (CABasicAnimation)

/// 位移
/// @param startPoint 开始位置
/// @param endPoint 结束位置
/// @param duration 持续时间
- (void)mk_positionAnimationWithStartPoint:(CGPoint)startPoint
                                          endPoint:(CGPoint)endPoint
                                          duration:(CFTimeInterval)duration;

/// 透明度
/// @param startAlpha 开始透明度（0 ~ 1）
/// @param endAlpha 结束透明度（0 ~ 1）
/// @param duration 持续时间
- (void)mk_opacityanimationWithStartAlpha:(CGFloat)startAlpha
                                 endAlpha:(CGFloat)endAlpha
                                 duration:(CFTimeInterval)duration;

/// 位置&大小
/// @param endBounds 结束位置&大小
/// @param repeatCount 重复次数
/// @param duration 持续时间
- (void)mk_boundsAnimationWithEndBounds:(CGRect)endBounds
                               duration:(CFTimeInterval)duration
                            repeatCount:(CGFloat)repeatCount;

/// 大小（中心点不变）
/// @param endSize 结束大小
/// @param duration 持续时间
- (void)mk_sizeAnimationWithEndSize:(CGSize)endSize
                           duration:(CFTimeInterval)duration;

/// 圆角
/// @param cornerRadius 圆角半径
/// @param duration 持续时间
- (void)mk_roundCornerAnimationWithCornerRadius:(CGFloat)cornerRadius
                                       duration:(CFTimeInterval)duration;

/// 边框线条宽度（border是图形周围边框，默认为黑色）
/// @param borderWidth 线条宽度
/// @param duration 持续时间
- (void)mk_borderWidthAnimationWithBorderWith:(CGFloat)borderWidth
                                     duration:(CFTimeInterval)duration;

/// 缩放动画
/// @param startScale 开始比例
/// @param endScale 结束比例
/// @param duration 持续时间
- (void)mk_transformScaleAnimationWithStartScale:(CGFloat)startScale
                                        endScale:(CGFloat)endScale
                                        duration:(CFTimeInterval)duration;

/// 翻转动画（x轴）
/// @param angle 角度
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_xRotationAnimationWithAngle:(CGFloat)angle
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount;

/// 翻转动画（y轴）
/// @param angle 角度
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_yRotationAnimationWithAngle:(CGFloat)angle
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount;

/// 翻转动画（z轴）
/// @param angle 角度
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_zRotationAnimationWithAngle:(CGFloat)angle
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount;

/// 平移动画（x轴）
/// @param length 移动距离
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_xTranslationAnimationWithLength:(CGFloat)length
                                  duration:(CFTimeInterval)duration
                               repeatCount:(CGFloat)repeatCount;

/// 平移动画（y轴）
/// @param length 移动距离
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_yTranslationAnimationWithLength:(CGFloat)length
                                  duration:(CFTimeInterval)duration
                               repeatCount:(CGFloat)repeatCount;

/// 平移动画（z轴）
/// @param length 移动距离
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_zTranslationAnimationWithLength:(CGFloat)length
                                  duration:(CFTimeInterval)duration
                               repeatCount:(CGFloat)repeatCount;

@end

NS_ASSUME_NONNULL_END
