//
//  UIView+MKExtension.m
//  FEOA
//
//  Created by jun on 2017/10/27.
//  Copyright © 2017年 flyrise. All rights reserved.
//

#import "UIView+MKExtension.h"

@implementation UIView (MKExtension)

#pragma mark - Setter/Getter

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

#pragma mark - Public Function

- (void)mk_borderWithColor:(UIColor *)color width:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)mk_debugBorderWithColor:(UIColor *)color width:(CGFloat)width {
#if Debug_Apeman || Debug_Crosstour || Debug_Victure
//#if DEBUG
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
#endif
}

- (void)mk_resetRoundCorner:(UIRectCorner)corners {
    // 使按钮布局立即生效，防止下面拿不到CGSize
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(self.bounds.size.height * 0.5, self.bounds.size.height * 0.5)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

- (void)mk_resetRoundCorner:(UIRectCorner)corners radius:(CGFloat)radius {
    // 使按钮布局立即生效，防止下面拿不到CGSize
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    // 检测半径
    if (radius <= 0) {
        return;
    }
    if (self.bounds.size.height > self.bounds.size.width) {
        if (radius > self.bounds.size.width * 0.5) {
            return;
        }
    } else {
        if (radius > self.bounds.size.height * 0.5) {
            return;
        }
    }
    
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

- (void)mk_addTapGestureWithTarget:(nullable id)target
                            action:(nullable SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)mk_drawDottedLineOnTargetView:(UIView *)targetView
                               length:(int)length
                              spacing:(int)spacing
                                color:(UIColor *)color
                            direction:(BOOL)isHorizonal {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:targetView.bounds];
    if (isHorizonal) {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(targetView.frame) / 2, CGRectGetHeight(targetView.frame))];
    } else {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(targetView.frame) / 2, CGRectGetHeight(targetView.frame)/2)];
    }
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:color.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(targetView.frame)];
    } else {
        [shapeLayer setLineWidth:CGRectGetWidth(targetView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:length], [NSNumber numberWithInt:spacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(targetView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(targetView.frame));
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [targetView.layer addSublayer:shapeLayer];
}

- (void)mk_prepareToShow {
    self.alpha = 0;
}

- (void)mk_makeViewVisible {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

- (UIViewController *)mk_currentVC {
    UIResponder* responder = self;
    while (responder != nil && ![responder isKindOfClass:UIViewController.class]) {
        responder = responder.nextResponder;
    }
    return (UIViewController *)responder;
}
@end
