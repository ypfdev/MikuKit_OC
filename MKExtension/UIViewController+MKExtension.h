//
//  UIViewController+MKExtension.h
//  Miku
//
//  Created by 原鹏飞 on 16/5/18.
//  Copyright © 2016年 原鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MKExtension)

/**
 * 在当前视图控制器中添加子控制器，将子控制器的视图添加到 view 中
 *
 * @param childController 要添加的子控制器
 * @param view            要添加到的视图
 */
- (void)mk_addChildController:(UIViewController *)childController intoView:(UIView *)view;

@end