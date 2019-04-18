//
//  UIAlertController+PPP.h
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/16.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (PPP)

+ (UIAlertController *)pf_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

@end

NS_ASSUME_NONNULL_END