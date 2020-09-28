//
//  MCTipsUtils.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MCTipsOrientation) {
    MCTipsOrientationPortrait               = 0,    // 竖屏（默认）
    MCTipsOrientationPortraitUpsideDown     = 1,    // 竖屏（上下翻转）
    MCTipsOrientationLandscapeLeft          = 2,    // 左横屏（竖屏顺时针旋转90°）
    MCTipsOrientationLandscapeRight         = 3,    // 右横屏（竖屏逆时针旋转90°）
};

/**
 通用提示语类型
 */
typedef NS_ENUM(NSInteger, NormalTips){
    NormalTipsLoading             = 1,     /**< 正在加载*/
    NormalTipsSending             = 2,     /**< 正在发送*/
    NormalTipsConnecting          = 3,     /**< 正在连接*/
    NormalTipsLogining            = 4,     /**< 正在登陆*/
    NormalTipsNetworkUnusual      = 100,   /**< 网络异常*/
    NormalTipsNetworkTimeout      = 101,   /**< 连接超时*/
    NormalTipsRequestFailed       = 102,   /**< 请求失败*/
    NormalTipsOperationSuccess    = 103,   /**< 操作成功*/
    NormalTipsDownloadFail        = 104,   /**< 下载失败*/
};

/**
 提示语工具类
 */
@interface MCTipsUtils : NSObject

#pragma mark - 通用提示

/// 常用提示语
/// @param type 通用提示语类型
+ (void)showNormalTips:(NormalTips)type;

#pragma mark - 提示（带菊花）

/**
 白色背景遮挡内容的菊花（view上，需手动隐藏）
 */
+ (void)showMaskHUDWithMessage:(NSString *)message inView:(UIView *)view;

/// 菊花（Windows上，需要手动隐藏）
+ (void)showHUD;

/// 带信息菊花（Window上，需手动隐藏）
/// @param message 提示信息
+ (void)showHUDWithMessage:(NSString *)message;

/// 带信息菊花（View上，需手动隐藏）
/// @param message 提示信息
/// @param view 提示控件的父视图
+ (void)showHUDWithMessage:(NSString *)message inView:(UIView *)view;

/// 带信息菊花（View上，自动隐藏）
/// @param message 提示信息
/// @param view 显示提示的View
/// @param time 自动隐藏延迟时间
+ (void)showHUDWithMessage:(NSString *)message inView:(UIView *)view delay:(NSTimeInterval)time;

#pragma mark - 提示（不带菊花）

/// 提示（Window上，1.5s后自动隐藏）
/// @param message 提示信息
+ (void)showTips:(NSString *)message;

/// 提示（Window上，1.5s后自动隐藏）
/// @param message 提示信息
/// @param orientation 提示框方向
+ (void)showTips:(NSString *)message orientation:(MCTipsOrientation)orientation;

/// 根据网络请求返回的code，显示提示信息（Window上，1.5s后自动隐藏）
/// @param code 网络请求返回的code
/// @param successMsg code==1000时的自定义提示
/// @param originalMsg 服务器返回的提示
+ (void)showTipsWithCode:()code successMsg:(nullable NSString *)successMsg originalMsg:(nullable NSString *)originalMsg;

/// 提示（Window上，显示在底部，1.5s后自动隐藏）
/// @param message 提示信息
+ (void)showBottomTips:(NSString *)message;

/// 提示（Window上，显示在顶部，1.5s后自动隐藏）
/// @param message 提示信息
+ (void)showTopTips:(NSString *)text;

/// 提示（View上，1.5s后自动隐藏）
/// @param message 提示信息
/// @param view 提示控件的父视图
+ (void)showTips:(NSString *)message inView:(UIView *)view;

/// 提示（View上，自动隐藏）
/// @param message 提示信息
/// @param view 提示控件的父视图
/// @param time 自动隐藏时间（default:1s）
+ (void)showTips:(NSString *)message inView:(UIView *)view delay:(NSTimeInterval)time;

/// 提示（View上，自动隐藏）
/// @param message 提示信息
/// @param view 提示控件的父视图
/// @param time 自动隐藏时间
/// @param yOffset 距离中心点的Y轴的位置
+ (void)showTips:(NSString *)message inView:(UIView *)view delay:(NSTimeInterval)time yOffset:(CGFloat)yOffset;

#pragma mark - 成功，失败

/// 成功提示（View上，自动隐藏）
/// @param message 提示信息
+ (void)showSuccessWithTips:(NSString *)message;

/// 成功提示（View上，自动隐藏）
/// @param message 提示信息
/// @param time 自动隐藏时间
+ (void)showSuccessWithTips:(NSString *)message delay:(NSTimeInterval)time;

/// 错误提示（View上，自动隐藏）
/// @param message 提示信息
+ (void)showErrorWithTips:(NSString *)message;

/// 错误提示（View上，自动隐藏）
/// @param message 提示信息
/// @param time 自动隐藏时间
+ (void)showErrorWithTips:(NSString *)message delay:(NSTimeInterval)time;

#pragma mark - 隐藏

/// 隐藏提示控件
+ (void)hideHUD;

/// 隐藏提示控件
/// @param view 提示控件的父视图
+ (void)hideHUDWithView:(UIView *)view;

@end


@interface GHUDHelp : NSObject

@property (nonatomic, strong) NSMutableArray * hudViews;

+ (GHUDHelp *)share;

@end

NS_ASSUME_NONNULL_END
