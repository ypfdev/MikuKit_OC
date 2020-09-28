//
//  UIBarButtonItem+MKExtension.m
//  FEOA
//
//  Created by jun on 2017/11/7.
//  Copyright © 2017年 flyrise. All rights reserved.
//

#import "UIBarButtonItem+MKExtension.h"
#import "UIView+MKExtension.h"

@implementation UIBarButtonItem (MKExtension)

+ (UIBarButtonItem *)mk_itemWithIcon:(UIImage *)icon
                            highIcon:(UIImage *)highIcon
                              target:(id)target
                              action:(SEL)action {
    //    BackView *customView = [[BackView alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    //    [customView addGestureRecognizer:tap];
    //    customView.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    customView.btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    //    if (icon) {
    //        [customView.btn setBackgroundImage:icon forState:UIControlStateNormal];
    //    }
    //    if (highIcon) {
    //        [customView.btn setBackgroundImage:highIcon forState:UIControlStateHighlighted];
    //    }
    //    customView.btn.frame = CGRectMake(0, 0, customView.btn.currentBackgroundImage.size.width, customView.btn.currentBackgroundImage.size.height);
    //    customView.btn.centerY = customView.centerY;
    //    [customView.btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //    [customView addSubview:customView.btn];
    //    return  [[UIBarButtonItem alloc] initWithCustomView:customView];
    return  [UIBarButtonItem mk_itemWithIcon:icon
                                    highIcon:highIcon
                                   alignment:UIControlContentHorizontalAlignmentLeft
                                      target:target
                                      action:action];
}

+ (UIBarButtonItem *)mk_itemWithIcon:(UIImage *)icon
                            highIcon:(UIImage *)highIcon
                           alignment:(UIControlContentHorizontalAlignment)align
                              target:(id)target
                              action:(SEL)action {
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    item.bounds = CGRectMake(0, 0, 44, 44);
    [item setImage:icon forState:UIControlStateNormal];
    [item setImage:highIcon forState:UIControlStateHighlighted];
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [item setContentHorizontalAlignment:align];
    return  [[UIBarButtonItem alloc] initWithCustomView:item];
}

+ (UIBarButtonItem *)mk_itemWithTitle:(NSString *)title
                               target:(id)target
                               action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0, title.length * 18, 44);
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)mk_itemWithTitle:(NSString *)title
                                 font:(CGFloat)fontsize
                          normalColor:(UIColor *)ncolor
                       highLightColor:(UIColor *)hcolor
                         disableColor:(UIColor *)dcolor
                               target:(id)target
                               action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontsize];
    [btn setTitleColor:ncolor forState:UIControlStateNormal];
    if (dcolor) {
        [btn setTitleColor:dcolor forState:UIControlStateDisabled];
    }
    if (hcolor) {
        [btn setTitleColor:hcolor forState:UIControlStateHighlighted];
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end


@implementation BackView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UINavigationBar *navBar = nil;
    UIView *aView = self.superview;
    while (aView) {
        if ([aView isKindOfClass:[UINavigationBar class]]) {
            navBar = (UINavigationBar *)aView;
            break;
        }
        aView = aView.superview;
    }
    UINavigationItem *navItem = (UINavigationItem *)navBar.items.lastObject;
    UIBarButtonItem *leftItem = navItem.leftBarButtonItem;
    UIBarButtonItem *rightItem = navItem.rightBarButtonItem;
    
    // 右边按钮
    if (rightItem) {
        BackView *backView = rightItem.customView;
        if ([backView isKindOfClass:self.class]) {
            CGRect frame = backView.btn.frame;
            frame.origin.x = backView.frame.size.width - backView.btn.frame.size.width;
        }
    }
    // 左边按钮
    if (leftItem) {
        
    }
}

@end
