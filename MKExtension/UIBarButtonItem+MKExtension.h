//
//  UIBarButtonItem+MKExtension.h
//  FEOA
//
//  Created by jun on 2017/11/7.
//  Copyright © 2017年 flyrise. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BackView;

@interface UIBarButtonItem (MKExtension)

+ (UIBarButtonItem *)mk_itemWithTitle:(NSString *)title
                               target:(id)target
                               action:(SEL)action;

+ (UIBarButtonItem *)mk_itemWithIcon:(UIImage *)icon
                            highIcon:(UIImage *)highIcon
                              target:(id)target
                              action:(SEL)action;

+ (UIBarButtonItem *)mk_itemWithIcon:(UIImage *)icon
                            highIcon:(UIImage *)highIcon
                           alignment:(UIControlContentHorizontalAlignment)align
                              target:(id)target
                              action:(SEL)action;

// UITabBar
+ (UIBarButtonItem *)mk_itemWithTitle:(NSString *)title
                                 font:(CGFloat)fontsize
                          normalColor:(UIColor *)ncolor
                       highLightColor:(UIColor *)hcolor
                         disableColor:(UIColor *)dcolor
                               target:(id)target
                               action:(SEL)action;

@end


@interface BackView:UIView

@property(nonatomic, strong) UIButton *btn;

@end
