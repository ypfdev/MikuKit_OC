//
//  UITextField+MKExtension.h
//  FeOAClient
//
//  Created by jun on 2018/1/2.
//  Copyright © 2018年 flyrise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MKExtension)

/// 快速设置占位符
/// @param placeholder 占位符
/// @param font 字体
/// @param color 颜色
- (void)mk_setPlaceholder:(NSString *)placeholder
                     font:(UIFont *)font
                    color:(UIColor *)color;

@end
