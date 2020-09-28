//
//  UIImage+MKExtension.h
//  PureGarden
//
//  Created by 原鹏飞 on 2017/7/28.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MKExtension)

/// 快速生成纯色图片
/// @param color 颜色对象
+ (UIImage *)mk_imageWithColor:(UIColor *)color;

/// 快速生成纯色图片
/// @param hex hex色值
+ (UIImage *)mk_imageWithHex:(uint32_t)hex;

/// 快速生成带透明度的纯色图片
/// @param hex hex色值
/// @param alpha 透明度（0.0 ~ 1.0）
+ (UIImage *)mk_imageWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

/// 生成指定大小的渐变图片
/// @param size 指定大小
+ (UIImage *)mk_gradientImageWithSize:(CGSize)size;

/// 裁切图片
/// @param originalImage 原图
/// @param rect 目标尺寸
+ (UIImage *)mk_croppedImageFromImage:(UIImage *)originalImage rect:(CGRect)rect;

/// 生成圆形图片（UIGraphics重新绘制）
/// @param image 待处理图片
+ (UIImage *)mk_circleImage:(UIImage *)image;

/// 生成圆形图片（UIGraphics重新绘制）
- (UIImage *)mk_circleImage;

/// 生成带圆环的圆形图片
/// @param loopWidth 圆环宽度
/// @param color 圆环颜色
- (UIImage *)mk_circleImageWithLoopWidth:(float)loopWidth andLoopColor:(UIColor *)color;


/// 重新渲染图片的颜色
/// @param color 颜色对象
- (UIImage *)mk_redrawWithColor:(UIColor *)color;

/// 重新渲染图片的颜色
/// @param hex 16进制颜色
/// @param alpha 透明度
- (UIImage *)mk_redrawWithHexColor:(uint32_t)hex alpha:(CGFloat)alpha;

/// 重新绘制图片（指定比例）（建议将大尺寸图片重绘成小尺寸）
/// @param scale 目标比例
- (UIImage *)mk_redrawWithScale:(CGFloat)scale;

/// 重新绘制图片（指定尺寸）（一般将大尺寸图片重绘成小尺寸）
/// @param size 目标尺寸
- (UIImage *)mk_redrawWithSize:(CGSize)size;

/// 图片转base64字符串
- (NSString *)mk_base64String;

@end
