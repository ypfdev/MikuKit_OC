//
//  XTImageButton.h
//  MotionCamera
//
//  Created by 青狼 on 2020/5/20.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTImageButton : UIButton

typedef NS_ENUM(NSInteger, XTImagePosition) {
    XTImagePositionLeft = 0,              //图片在左，文字在右，默认
    XTImagePositionRight = 1,             //图片在右，文字在左
    XTImagePositionTop = 2,               //图片在上，文字在下
    XTImagePositionBottom = 3,            //图片在下，文字在上
};


/** 按钮点击回调*/
@property (nonatomic,copy) void (^buttonEventsBlock)(void);

/** 设置图片位置和间隙
 @param postion 图片位置
 @param spacing 间隙大小
 */
- (void)setImagePosition:(XTImagePosition)postion spacing:(CGFloat)spacing;

/** 设置图片和标题
 @param image 图片
 @param title 标题
 */
- (void)setImage:(UIImage *)image title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
