//
//  UIView+MKExtension.h
//  FEOA
//
//  Created by jun on 2017/10/27.
//  Copyright © 2017年 flyrise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MKExtension)

@property (nonatomic,assign) CGFloat centerX;   // 中心点x坐标
@property (nonatomic,assign) CGFloat centerY;   // 中心店y坐标

/// 添加边框
/// @param color 线条颜色
/// @param width 线条宽度
- (void)mk_borderWithColor:(UIColor *)color width:(CGFloat)width;

/// 添加调试边框
/// @param color 线条颜色
/// @param width 线条宽度
- (void)mk_debugBorderWithColor:(UIColor *)color width:(CGFloat)width;

/// 快速切半圆角
/// @param corners 圆角方位的位移枚举
- (void)mk_resetRoundCorner:(UIRectCorner)corners;

/// 快速切指定半径圆角
/// （注意！仅适用于固定size视图，变化的视图使用时可能造成约束错误，例如自适应行高的TBCell的colorBG）
/// @param corners 圆角半径
/// @param radius 圆角方位的位移枚举
- (void)mk_resetRoundCorner:(UIRectCorner)corners radius:(CGFloat)radius;

/// 添加点击手势
/// @param target 目标
/// @param action 响应方法
- (void)mk_addTapGestureWithTarget:(nullable id)target
                            action:(nullable SEL)action;

/// 在view上画虚线（CAShapeLayer）
/// @param targetView 目标视图
/// @param length 线条长度
/// @param spacing 线条点距
/// @param color 线条颜色
/// @param isHorizonal 水平/垂直
- (void)mk_drawDottedLineOnTargetView:(UIView *)targetView
                               length:(int)length
                              spacing:(int)spacing
                                color:(UIColor *)color
                            direction:(BOOL)isHorizonal;

- (void)mk_prepareToShow;
- (void)mk_makeViewVisible;

/// 返回当前视图所属的控制器
- (UIViewController *)mk_currentVC;

@end

NS_ASSUME_NONNULL_END
