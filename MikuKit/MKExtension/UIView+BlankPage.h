//
//  UIView+BlankPage.h
//  MotionCamera
//
//  Created by SongYang on 2018/12/26.
//  Copyright © 2018 Galanz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BlankPage)
/** 空白页 */
@property (nonatomic, weak, readonly) UIView* blankPage;
- (void)setBlankPage:(UIView *)blankPage NS_UNAVAILABLE;

/**
 设置空白页

 @param imgName 图片名
 @param title 标题
 */
- (void)setBlankImageName:(NSString *)imgName titleName:(NSString *)title;

/** 默认空白页 */
- (void)showDefaultBlankContent;

/** 无网络 */
- (void)noNetworkWithRefreshBlock:(void(^)(void))refresh;

@end

NS_ASSUME_NONNULL_END
