//
//  MCMaskView.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/30.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCMaskView : UIView

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, copy) void(^showCompletion)(BOOL finish);

/// 全屏遮罩弹窗视图
/// @param contentView 内容视图
/// @param contentSize 内容视图的size
/// @param maskDismissEnable 是否支持点击遮罩区域退出
+ (MCMaskView *)maskViewWithContentView:(UIView *)contentView
                            contentSize:(CGSize)contentSize
                      maskDismissEnable:(BOOL)maskDismissEnable;

/// 全屏遮罩弹窗视图
/// @param contentView 内容视图
/// @param contentSize 内容视图的size
/// @param bSpacing 内容视图距离屏幕底部间距（内部已取负数）
/// @param maskDismissEnable 是否支持点击遮罩区域退出
+ (MCMaskView *)maskViewWithContentView:(UIView *)contentView
                            contentSize:(CGSize)contentSize
                          bottomSpacing:(CGFloat)bSpacing
                      maskDismissEnable:(BOOL)maskDismissEnable;

- (void)show;

- (void)showWithView:(UIView *)view;

- (void)dismiss;

@end
