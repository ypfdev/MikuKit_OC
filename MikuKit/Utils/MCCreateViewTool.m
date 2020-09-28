//
//  MCCreateViewTool.m
//  MotionCamera
//
//  Created by 青狼 on 2020/5/6.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCCreateViewTool.h"

@implementation MCCreateViewTool

+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = alignment;
    return label;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame font:(UIFont *)font titleColor:(UIColor *)titleColor title:(NSString *)title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame contentModel:(UIViewContentMode)model image:(UIImage *)image
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = model;
    [imageView setImage:image];
    return imageView;
}

+ (void)cornerView:(UIView *)view radius:(CGFloat)radius
{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

@end
