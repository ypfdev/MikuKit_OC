//
//  CALayer+CAKeyFrameAnimation.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/27.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "CALayer+CAKeyFrameAnimation.h"

@implementation CALayer (CAKeyFrameAnimation)

- (void)mk_xRockAnimationWithAmplitude:(CGFloat)amplitude
                             duration:(CFTimeInterval)duration
                          repeatCount:(CGFloat)repeatCount {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.values = @[@(0), @(amplitude), @(- amplitude), @(0)];
    animation.additive = YES;
    animation.duration = duration;
    animation.repeatCount =  repeatCount;
    [self addAnimation:animation forKey:@"xRockAnimation"];
}

- (void)mk_yRockAnimationWithAmplitude:(CGFloat)amplitude
                             duration:(CFTimeInterval)duration
                          repeatCount:(CGFloat)repeatCount {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation.values = @[@(0), @(amplitude), @(- amplitude), @(0)];
    animation.additive = YES;
    animation.duration = duration;
    animation.repeatCount =  repeatCount;
    [self addAnimation:animation forKey:@"yRockAnimation"];
}

- (void)mk_zRockAnimationWithAmplitude:(CGFloat)amplitude
                             duration:(CFTimeInterval)duration
                          repeatCount:(CGFloat)repeatCount {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.z"];
    animation.values = @[@(0), @(amplitude), @(- amplitude), @(0)];
    animation.additive = YES;
    animation.duration = duration;
    animation.repeatCount =  repeatCount;
    [self addAnimation:animation forKey:@"zRockAnimation"];
}

- (void)mk_circularAnimationWithRadius:(CGFloat)radius
                           duration:(CFTimeInterval)duration
                          repeatCount:(CGFloat)repeatCount {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, radius, radius);
    animation.path = CGPathCreateWithEllipseInRect(rect, nil);
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.duration = duration;
    animation.repeatCount =  repeatCount;
    [self addAnimation:animation forKey:@"circularAnimation"];
}

@end
