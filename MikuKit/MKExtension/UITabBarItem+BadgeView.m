//
//  UITabBarItem+BadgeView.m
//  FEOA
//
//  Created by jun on 2017/11/1.
//  Copyright © 2017年 flyrise. All rights reserved.
//

#import "UITabBarItem+BadgeView.h"
#import <objc/runtime.h>
#import "UIView+MKExtension.h"

static const void *kFEBadgeDotView = "FEBadgeDotView";

@implementation UITabBarItem (BadgeView)

#pragma mark - Setter/Getter

- (void)setBadgeDotView:(UIView *)badgeDotView{
    objc_setAssociatedObject(self, kFEBadgeDotView, badgeDotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)badgeDotView{
    return objc_getAssociatedObject(self, kFEBadgeDotView);
}

#pragma mark - Public Function

- (void)mk_showBadgeDotView{
    if (!self.badgeDotView) {
        UIView *barButtonView = [self valueForKeyPath:@"view"];
        UIView *swappableImageView = [barButtonView.subviews firstObject];
        CGFloat badgeWidth = 8;
        UIView *badgeView = [[UIView alloc] initWithFrame:CGRectMake(swappableImageView.frame.size.width - 1, 0, badgeWidth, badgeWidth)];
        [badgeView mk_resetRoundCorner:UIRectCornerAllCorners radius:badgeWidth * 0.5];
        badgeView.hidden = YES;
        badgeView.backgroundColor =  COLOR_AP_THEME;
        [swappableImageView addSubview:badgeView];
        self.badgeDotView = badgeView;
    }
    self.badgeDotView.hidden = NO;
}

@end
