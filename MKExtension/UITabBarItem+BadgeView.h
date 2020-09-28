//
//  UITabBarItem+BadgeView.h
//  FEOA
//
//  Created by jun on 2017/11/1.
//  Copyright © 2017年 flyrise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (BadgeView)

@property (strong, nonatomic) UIView *badgeDotView;

/// 显示未读小红点
- (void)mk_showBadgeDotView;

@end
