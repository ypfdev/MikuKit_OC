//
//  UIButton+MKExtension.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2018/12/12.
//  Copyright © 2018 Galanz. All rights reserved.
//

#import "UIButton+MKExtension.h"
#import <objc/runtime.h>

@implementation UIButton (MKExtension)

+ (UIButton *)mk_buttonWithNormalTitle:(NSString *)mormalTitle
                           normalColor:(UIColor *)normalColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:mormalTitle forState:UIControlStateNormal];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)mk_buttonWithNormalTitle:(NSString *)normalTitle
                           normalColor:(UIColor *)normalColor
                           borderWidth:(CGFloat)borderWidth
                           borderColor:(UIColor *)borderColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn.layer setBorderWidth:borderWidth];
    [btn.layer setBorderColor:borderColor.CGColor];
    return btn;
}

+ (UIButton *)mk_buttonWithNormalTitle:(NSString *)normalTitle
                           normalColor:(UIColor *)normalColor
                         selectedTitle:(NSString *)selectedTitle
                         selectedColor:(UIColor *)selectedColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    return btn;
}

+ (UIButton *)mk_buttonWithNormalTitle:(NSString *)normalTitle
                           normalColor:(UIColor *)normalColor
                         selectedTitle:(NSString *)selectedTitle
                         selectedColor:(UIColor *)selectedColor
                           borderWidth:(CGFloat)borderWidth
                           borderColor:(UIColor *)borderColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    [btn.layer setBorderColor:borderColor.CGColor];
    [btn.layer setBorderWidth:borderWidth];
    return btn;
}

#pragma mark - 扩大按钮的点击区域

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)mk_enlargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)mk_enlargeEdgeWithTop:(CGFloat)top AndLeft:(CGFloat)left AndBottom:(CGFloat)bottom AndRight:(CGFloat)right {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (CGRect)mk_enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect rect = [self mk_enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}


#pragma mark - 快速创建仅文字无图片的按钮

/**
 快速创建文字按钮

 @param title 按钮文字
 @param fontSize 字号
 @param normalColor 默认状态下文字的颜色
 @param selectedColor 选中状态下文字的颜色
 @return 返回创建的按钮
 */
+ (instancetype)mk_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [button sizeToFit];
    
    return button;
}

@end
