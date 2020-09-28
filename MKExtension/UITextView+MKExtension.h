//
//  UITextView+MKExtension.h
//  FeOAClient
//
//  Created by jun on 2017/12/29.
//  Copyright © 2017年 flyrise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (MKExtension)

/// 快速设置占位符
/// @param placeholder 占位符
/// @param font 字体
/// @param color 颜色
- (void)mk_setPlaceholder:(NSString *)placeholder
                     font:(UIFont *)font
                    color:(UIColor *)color;

@end
