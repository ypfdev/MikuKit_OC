//
//  UILabel+Addition.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/10/29.
//  Copyright © 2018 ypf. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

+ (UILabel *)pf_labelWithText:(NSString *)text andFont:(UIFont *)font andTextColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] init];
    [label setText:text];
    [label setFont:font];
    [label setTextColor:textColor];
    return label;
}

@end
