//
//  UIImage+Addition.h
//  PFAMapDemo
//
//  Created by 原鹏飞 on 2018/11/15.
//  Copyright © 2018 原鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Addition)

/**
 根据颜色生成纯色填充的图片
 
 @param color 颜色
 @return 纯色图片
 */
+ (UIImage *)pf_imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
