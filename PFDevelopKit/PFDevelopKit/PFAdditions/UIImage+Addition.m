//
//  UIImage+Addition.m
//  PFAMapDemo
//
//  Created by 原鹏飞 on 2018/11/15.
//  Copyright © 2018 原鹏飞. All rights reserved.
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)

/**
 根据颜色生成纯色填充的图片

 @param color 颜色
 @return 纯色图片
 */
+ (UIImage *)pf_imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
