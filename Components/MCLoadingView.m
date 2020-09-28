//
//  MCLoadingView.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/29.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCLoadingView.h"

@interface MCLoadingView ()

@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, strong) UIImageView *iv;

@end

@implementation MCLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.angle = 0;
        self.iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_load"]];
        [self addSubview:self.iv];
        [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.height.width.mas_equalTo(self);
        }];
        [self animation_CABasicAnimation];
    }
    return self;
}


#pragma mark - 方法1：UIView动画

// MARK: DeprecatedAnimations实现【ios(2.0, 13.0)】

- (void)rotation_UIViewDeprecatedAnimations {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(rotation_UIViewDeprecatedAnimations_stop)];
    self.iv.transform = CGAffineTransformRotate(self.iv.transform, M_2_PI);
    [UIView commitAnimations];
}

- (void)rotation_UIViewDeprecatedAnimations_stop {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self rotation_UIViewDeprecatedAnimations];
    });
}

// MARK: UIViewAnimationWithBlocks实现【ios(4.0)】
- (void)rotation_UIViewAnimationWithBlocks {
    // 如果需要解除触摸、手势等禁用，可以在options中添加支持用户交互
//    UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.iv.transform = CGAffineTransformRotate(self.iv.transform, M_2_PI);
    } completion:^(BOOL finished) {
        [self rotation_UIViewAnimationWithBlocks];
    }];
}


#pragma mark - 方法2：CAAnimation

// MARK: CABasicAnimation实现
- (void)animation_CABasicAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    animation.duration = 1.5;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    
    [self.iv.layer addAnimation:animation forKey:@"transform.rotation.z"];
}

// MARK: CAKeyframeAnimation实现
- (void)animation_CoreGraphics {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationPaced;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    
    // 设置路径 CGPath只对layer的anchorPoint或position属性起作用
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.iv.center.x, self.iv.center.y, 1, 0, M_PI * 2, false);
    animation.path = path;
    CGPathRelease(path);
    
    [self.iv.layer addAnimation:animation forKey:@"rotation"];
}


#pragma mark - 移除动画

- (void)stopAnimation {
    [self.iv.layer removeAllAnimations];
    [self.layer removeAllAnimations];
}


#pragma mark - 效果比较

/** 效果对比
触发场景：相机预览-选项设置面板中，设置相机参数
loading动画：UIView动画会卡住；CAAnimation刚出现时会闪烁两次
*/

@end
