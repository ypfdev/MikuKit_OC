//
//  UILabel+Addition.h
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/10/29.
//  Copyright © 2018 ypf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Addition)

+ (UILabel *)pf_labelWithText:(NSString *)text andFont:(UIFont *)font andTextColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
