//
//  UIButton+Addition.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/10/29.
//  Copyright © 2018 ypf. All rights reserved.
//

#import "UIButton+Addition.h"
#import <WebKit/WebKit.h>

@implementation UIButton (Addition)

/**
 快速创建按钮

 @param title 按钮文字
 @param titleColor 按钮文字颜色
 @return 按钮
 */
+ (UIButton *)pf_buttonWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    return btn;
}


/**
 快速创建带边框按钮

 @param title 按钮文字
 @param titleColor 按钮文字颜色
 @param borderWidth 按钮边框宽度
 @param borderColor 按钮边框颜色
 @return 带边框的按钮
 */
+ (UIButton *)pf_buttonWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andBorderWidth:(CGFloat)borderWidth andBorderColor:(CGColorRef)borderColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn.layer setBorderWidth:borderWidth];
    [btn.layer setBorderColor:borderColor];
    
    return btn;
}


/**
 快速创建选中文字变色的按钮

 @param title 按钮正常状态文字
 @param titleColor 按钮正常状态文字颜色
 @param selectedTitle 按钮选中状态文字
 @param selectedColor 按钮选中状态文字颜色
 @return 选中文字变色的按钮
 */
+ (UIButton *)pf_buttonWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andSelectedTitle:(NSString *)selectedTitle andSelectedColor:(UIColor *)selectedColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    return btn;
}


/**
 快速创建带边框的选中文字变色的按钮

 @param title 按钮正常状态文字
 @param titleColor 按钮正常状态文字颜色
 @param selectedTitle 按钮选中状态文字
 @param selectedColor 按钮选中状态文字颜色
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 带边框的选中文字变色的按钮
 */
+ (UIButton *)pf_buttonWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andSelectedTitle:(NSString *)selectedTitle andSelectedColor:(UIColor *)selectedColor andBorderWidth:(CGFloat)borderWidth  andBorderColor:(CGColorRef)borderColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    [btn.layer setBorderColor:borderColor];
    [btn.layer setBorderWidth:borderWidth];
    return btn;
}

@end
