//
//  UIActivityViewController+MKExtension.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/10/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "UIActivityViewController+MKExtension.h"

@implementation UIActivityViewController (MKExtension)

+ (void)mk_shareWithItems:(NSArray *)items target:(id)target completionWithItemsHandler:(UIActivityViewControllerCompletionWithItemsHandler)completionWithItemsHandler {
    // 原生分享必须保证分享对象数组不为空，否则会crash
    if (items.count == 0) {
        [MCTipsUtils showTips:@"Nothing to share."];
        return;
    }
    if (target == nil) {
        [MCTipsUtils showTips:@"No previous page."];
        return;
    }
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    if (@available(iOS 11.0, *)) {
        // UIActivityTypeMarkupAsPDF是在iOS 11.0 之后才有的
        activityVC.excludedActivityTypes = @[UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypeOpenInIBooks,UIActivityTypeMarkupAsPDF];
    } else if (@available(iOS 9.0, *)) {
        // UIActivityTypeOpenInIBooks是在iOS 9.0 之后才有的
        activityVC.excludedActivityTypes = @[UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypeOpenInIBooks];
    } else {
        activityVC.excludedActivityTypes = @[UIActivityTypeMessage,UIActivityTypeMail];
    }
    // 分享结束的回调
    activityVC.completionWithItemsHandler = completionWithItemsHandler;
    
    // 这儿一定要做iPhone与iPad的判断，因为这儿只有iPhone可以present，iPad需pop，所以这儿actVC.popoverPresentationController.sourceView = self.view;在iPad下必须有，不然iPad会crash，self.view你可以换成任何view，你可以理解为弹出的窗需要找个依托。
    UIViewController *vc = target;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // iPad
        activityVC.popoverPresentationController.sourceView = vc.view;
        [vc presentViewController:activityVC animated:YES completion:nil];
    } else {
        [vc presentViewController:activityVC animated:YES completion:nil];
    }
    
}

@end
