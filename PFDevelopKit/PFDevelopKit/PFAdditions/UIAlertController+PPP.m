//
//  UIAlertController+PPP.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/16.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "UIAlertController+PPP.h"

@implementation UIAlertController (PPP)

+ (UIAlertController *)pf_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    [alertC addAction:cancelAction];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"破坏" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"破坏");
    }];
    [alertC addAction:destructiveAction];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确认");
    }];
    [alertC addAction:confirmAction];
    
    return alertC;
}

@end
