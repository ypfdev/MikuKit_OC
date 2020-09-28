//
//  CALayer+CABasicAnimation.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/27.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "CALayer+CABasicAnimation.h"

@implementation CALayer (CABasicAnimation)

- (void)mk_positionAnimationWithStartPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint
                                  duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:startPoint];
    animation.toValue = [NSValue valueWithCGPoint:endPoint];
    animation.duration = 3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self addAnimation:animation forKey:@"positionAnimation"];
}

- (void)mk_opacityanimationWithStartAlpha:(CGFloat)startAlpha
                                 endAlpha:(CGFloat)endAlpha
                                 duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:startAlpha];
    animation.toValue = [NSNumber numberWithFloat:endAlpha];
    animation.duration = duration;
    [self addAnimation:animation forKey:@"opacityAnimation"];
}

- (void)mk_boundsAnimationWithEndBounds:(CGRect)endBounds
                               duration:(CFTimeInterval)duration
                            repeatCount:(CGFloat)repeatCount {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.fromValue = [NSValue valueWithCGRect:self.bounds];
    animation.toValue = [NSNumber valueWithCGRect:endBounds];
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    [self addAnimation:animation forKey:@"boundsAnimation"];
}

- (void)mk_sizeAnimationWithEndSize:(CGSize)endSize
                           duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    animation.fromValue = [NSValue valueWithCGSize:self.bounds.size];
    animation.toValue = [NSValue valueWithCGSize:endSize];
    animation.duration = duration;
    [self addAnimation:animation forKey:@"sizeAnimation"];
}

- (void)mk_roundCornerAnimationWithCornerRadius:(CGFloat)cornerRadius
                                       duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.toValue = [NSNumber numberWithFloat:cornerRadius];
    animation.duration = duration;
    [self addAnimation:animation forKey:@"roundCornerAnimation"];
}

- (void)mk_borderWidthAnimationWithBorderWith:(CGFloat)borderWidth
                                     duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    animation.toValue = [NSNumber numberWithFloat:borderWidth];
    animation.duration = duration;
    [self addAnimation:animation forKey:@"borderWidthAnimation"];
}

- (void)mk_transformScaleAnimationWithStartScale:(CGFloat)startScale
                                        endScale:(CGFloat)endScale
                                        duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:startScale];
    animation.toValue = [NSNumber numberWithFloat:endScale];
    animation.duration = duration;
    animation.autoreverses = YES;
    [self addAnimation:animation forKey:@"transformScaleAnimation"];
}


/// 翻转动画（x轴）
/// @param angle 角度
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_xRotationAnimationWithAngle:(CGFloat)angle
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.toValue = [NSNumber numberWithFloat:angle];
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    // 添加渐入渐出的动画效果（动画在开始和结束时相对慢一点）
    // 默认值是kCAMediaTimingFunctionLinear（线性，即匀速的）
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self addAnimation:animation forKey:@"xRotationAnimation"];
}

/// 翻转动画（y轴）
/// @param angle 角度
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_yRotationAnimationWithAngle:(CGFloat)angle
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = [NSNumber numberWithFloat:angle];
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    // 添加渐入渐出的动画效果（动画在开始和结束时相对慢一点）
    // 默认值是kCAMediaTimingFunctionLinear（线性，即匀速的）
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self addAnimation:animation forKey:@"yRotationAnimation"];
}

/// 翻转动画（z轴）
/// @param angle 角度
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_zRotationAnimationWithAngle:(CGFloat)angle
                              duration:(CFTimeInterval)duration
                           repeatCount:(CGFloat)repeatCount {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:angle];
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    // 添加渐入渐出的动画效果（动画在开始和结束时相对慢一点）
    // 默认值是kCAMediaTimingFunctionLinear（线性，即匀速的）
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self addAnimation:animation forKey:@"zRotationAnimation"];
}

/// 平移动画（x轴）
/// @param length 移动距离
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_xTranslationAnimationWithLength:(CGFloat)length
                                  duration:(CFTimeInterval)duration
                               repeatCount:(CGFloat)repeatCount {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue = [NSNumber numberWithFloat:length];
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    // 添加渐入渐出的动画效果（动画在开始和结束时相对慢一点）
    // 默认值是kCAMediaTimingFunctionLinear（线性，即匀速的）
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self addAnimation:animation forKey:@"xTranslationAnimation"];
}

/// 平移动画（y轴）
/// @param length 移动距离
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_yTranslationAnimationWithLength:(CGFloat)length
                                  duration:(CFTimeInterval)duration
                               repeatCount:(CGFloat)repeatCount {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue = [NSNumber numberWithFloat:length];
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    // 添加渐入渐出的动画效果（动画在开始和结束时相对慢一点）
    // 默认值是kCAMediaTimingFunctionLinear（线性，即匀速的）
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self addAnimation:animation forKey:@"yTranslationAnimation"];
}

/// 平移动画（z轴）
/// @param length 移动距离
/// @param duration 持续时间
/// @param repeatCount 重复次数
- (void)mk_zTranslationAnimationWithLength:(CGFloat)length
                                  duration:(CFTimeInterval)duration
                               repeatCount:(CGFloat)repeatCount {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.z"];
    animation.toValue = [NSNumber numberWithFloat:length];
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    // 添加渐入渐出的动画效果（动画在开始和结束时相对慢一点）
    // 默认值是kCAMediaTimingFunctionLinear（线性，即匀速的）
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self addAnimation:animation forKey:@"zTranslationAnimation"];
}



#pragma mark - 暂未成功的动画

- (void)mk_backgroundColorAnimationWithEndColor:(UIColor *)endColor
                                       duration:(CFTimeInterval)duration {
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    animation.fromValue = [UIColor redColor].CGColor;
//    self.backgroundColor;
//    animation.toValue = endColor;
//    animation.duration = duration;
//    [self addAnimation:animation forKey:@"backgroundColorAnimation"];
}

- (void)contentsAnimationWith:(UIImage *)image
                     duration:(CFTimeInterval)duration {
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
//    CGImageRef toImage = image.CGImage;
//    animation.toValue = toImage;
//    animation.duration = duration;
//    [self addAnimation:animation forKey:@"contentsAnimation"];
}

@end
