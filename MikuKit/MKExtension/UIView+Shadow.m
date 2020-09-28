//
//  UIView+Shadow.m
//  MotionCamera
//
//  Created by 青狼 on 2020/5/12.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void)setCornerRadius:(CGFloat)radius ShadowOffset:(CGSize)shadowOffset ShadowRadius:(CGFloat)shadowRadius Opacity:(CGFloat)opacity {
    
    self.layer.cornerRadius = radius;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = shadowRadius;
}


- (void)createTopCornerRadius{
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (void)createBottomCornerRadius{
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (void)createAllCornerRadius{
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

@end
