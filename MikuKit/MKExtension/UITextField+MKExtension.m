//
//  UITextField+MKExtension.m
//  FeOAClient
//
//  Created by jun on 2018/1/2.
//  Copyright © 2018年 flyrise. All rights reserved.
//

#import "UITextField+MKExtension.h"
#import <UIKit/UIKit.h>

@implementation UITextField (MKExtension)

- (void)mk_setPlaceholder:(NSString *)placeholder
                     font:(UIFont *)font
                    color:(UIColor *)color {
    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder];
    if (font) [attributedPlaceholder addAttribute:NSForegroundColorAttributeName
                        value:color
                        range:NSMakeRange(0, placeholder.length)];
    if (color) [attributedPlaceholder addAttribute:NSFontAttributeName
                        value:font
                        range:NSMakeRange(0, placeholder.length)];
    self.attributedPlaceholder = attributedPlaceholder;
}

@end
