//
//  MCCreateViewTool.h
//  MotionCamera
//
//  Created by 青狼 on 2020/5/6.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCCreateViewTool : NSObject

+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;

+ (UIButton *)createButtonWithFrame:(CGRect)frame font:(UIFont *)font titleColor:(UIColor *)titleColor title:(NSString *)title;

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame contentModel:(UIViewContentMode)model image:(UIImage *)image;

+ (void)cornerView:(UIView *)view radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
