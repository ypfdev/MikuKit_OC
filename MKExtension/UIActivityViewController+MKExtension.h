//
//  UIActivityViewController+MKExtension.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/10/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIActivityViewController (MKExtension)

/// 调用原生分享的方法
/// @param items 分享对象数组，元素可以是文字、图片、网址（即视频）
/// @param target 调用分享的控制器
/// @param completionWithItemsHandler 分享完成回调
+ (void)mk_shareWithItems:(NSArray *)items target:(id)target completionWithItemsHandler:(UIActivityViewControllerCompletionWithItemsHandler)completionWithItemsHandler;

@end

NS_ASSUME_NONNULL_END
