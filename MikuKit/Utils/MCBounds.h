//
//  MCBounds.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCBounds : NSObject

/// 屏幕高度
+ (CGFloat)screenH;

/// 屏幕宽度
+ (CGFloat)screenW;

/// 屏幕比例
+ (CGFloat)screenScale;

/// 状态栏高度
+ (CGFloat)statusBarH;

/// 导航栏高度 = 屏幕高度 - 状态栏&导航栏高度 - tabBar高度
+ (CGFloat)navH;

/// 状态栏&导航栏高度
+ (CGFloat)statusAndNavH;

/// 视图高度
+ (CGFloat)mainViewH;

/// 刘海屏底部圆角取余高度
+ (CGFloat)iPhoneXBottom;

/// tabBar 高度
/// 注意！如果是刘海屏，则已包含底部圆角取余高度；非刘海屏就是系统tabBar本身高度
+ (CGFloat)tabbarH;

/// 应用程序窗口高度（不包含状态栏高度）
/// 注意！因为状态栏是系统的，在新iPad上应用可能没有全屏
+ (CGFloat)appH;

/// 应用宽度
+ (CGFloat)appW;

@end

NS_ASSUME_NONNULL_END
