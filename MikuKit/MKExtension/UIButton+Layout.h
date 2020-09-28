//
//  UIButton+Layout.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/7.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Layout)

/// 按钮垂直对齐布局
/// @param spacing image和label的间距
- (void)verticalAlignButtonWithSpacing:(CGFloat)spacing;

/// 按钮水平对齐布局
/// @param spacing image和label的间距
/// @param offset y方向偏移量
- (void)horizontalAlignButtonWithSpacing:(CGFloat)spacing yOffset:(CGFloat)offset;

/// 重新布局：左文右图
- (void)mk_resetButton_titleLeftImageRight;

/// 重新布局：上图下文
/// @param btn 传入按钮
- (void)mk_resetButton:(UIButton*)btn;

/// 重新布局：上文下图
- (void)mk_resetButton;

/// 重新布局：上文下图，并设置文字颜色为灰色
- (void)mk_resetButtonDisable;

@end
