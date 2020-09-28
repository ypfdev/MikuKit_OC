//
//  UIImage+MKExtension.m
//  PureGarden
//
//  Created by 原鹏飞 on 2017/7/28.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "UIImage+MKExtension.h"

@implementation UIImage (MKExtension)

+ (UIImage *)mk_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)mk_imageWithHex:(uint32_t)hex {
    return [UIImage mk_imageWithColor:[UIColor mk_colorWithHex:hex]];
}

+ (UIImage *)mk_imageWithHex:(uint32_t)hex alpha:(CGFloat)alpha {
    return [UIImage mk_imageWithColor:[UIColor mk_colorWithHex:hex alpha:alpha]];
}

+ (UIImage *)mk_gradientImageWithSize:(CGSize)size {
    // 先生成一个渐变view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1.0, 0);
    gradient.frame = CGRectMake(0, 0, size.width, size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor mk_colorWithHex:0x318FFF].CGColor, (id)[UIColor mk_colorWithHex:0x6CD8FF].CGColor, nil];
    [view.layer insertSublayer:gradient atIndex:0];
    
    // 从渐变view获得渐变图片
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)mk_croppedImageFromImage:(UIImage *)originalImage rect:(CGRect)rect {
    CGImageRef originalImageRef = originalImage.CGImage;
    CGImageRef croppedImageRef = CGImageCreateWithImageInRect(originalImageRef, rect);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, croppedImageRef);
    UIImage *croppedImage = [UIImage imageWithCGImage:croppedImageRef];
    UIGraphicsEndImageContext();
    
    return croppedImage;
}

+ (UIImage *)mk_imageWithImage:(UIImage *)image scale:(CGFloat)scale {
    CGSize redrawSize = CGSizeMake(image.size.width * scale, image.size.height * scale);
    CGRect redrawRect = CGRectMake(0, 0, image.size.width * scale, image.size.height * scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], redrawRect);
    
    UIGraphicsBeginImageContext(redrawSize);
    [UIImage imageWithCGImage:imageRef];
    UIImage *redrawImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return redrawImage;
}

+ (UIImage *)mk_circleImage:(UIImage *)image {
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将原图片绘制到图形上下文
    [image drawInRect:rect];
    // 从上下文上获取剪裁后的
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return circleImage;
}

- (UIImage *)mk_circleImage {
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将原照片画到图形上下文
    [self drawInRect:rect];
    // 从上下文上获取剪裁后的照片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}

- (UIImage *)mk_circleImageWithLoopWidth:(float)loopWidth andLoopColor:(UIColor *)color {
    
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画圈
    // 设置一个范围
    CGRect loopRect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, loopRect);
    // 裁剪
    CGContextClip(ctx);
    // 将原照片画到图形上下文
    [[UIImage mk_imageWithColor:color] drawInRect:loopRect];
    
    //绘制图片
    // 设置一个范围
    CGRect imageRect = CGRectMake(loopWidth / 2, loopWidth / 2, self.size.width - loopWidth, self.size.height - loopWidth);
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, imageRect);
    // 裁剪
    CGContextClip(ctx);
    // 将原照片画到图形上下文
    [self drawInRect:imageRect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}

- (UIImage *)mk_redrawWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(contextRef, 0, self.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    CGContextSetBlendMode(contextRef, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(contextRef, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(contextRef, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)mk_redrawWithHexColor:(uint32_t)hex alpha:(CGFloat)alpha {
    /** 关于CGBlendMode枚举
     kCGBlendModeNormal,            // 正常（默认模式，前景图覆盖背景图）
     kCGBlendModeMultiply,           // 正片叠底（混合前景和背景的颜色，最终颜色比原本的颜色都淡）
     kCGBlendModeScreen,            // 滤色（先反转前景色和背景色，然后混合）
     kCGBlendModeOverlay,           // 覆盖（能保留灰度信息）
     kCGBlendModeDarken,            // 变暗
     kCGBlendModeLighten,            // 变亮
     kCGBlendModeColorDodge,    // 颜色变淡
     kCGBlendModeColorBurn,       // 颜色加深
     kCGBlendModeSoftLight,         // 柔光
     kCGBlendModeHardLight,        // 强光
     kCGBlendModeDifference,       // 插值
     kCGBlendModeExclusion,        // 排除
     kCGBlendModeHue,                 // 色调
     kCGBlendModeSaturation,       // 饱和度（能保留透明度信息）
     kCGBlendModeColor,               // 颜色
     kCGBlendModeLuminosity,      // 亮度
     
     // Apple额外定义的枚举
     // R：premultiplied result, 表示混合结果
     // S：Source, 表示源颜色(Sa对应透明度值: 0.0-1.0)
     // D：destination colors with alpha, 表示带透明度的目标颜色(Da对应透明度值: 0.0-1.0)
     // R表示结果，S表示包含alpha的原色，D表示包含alpha的目标色，Ra，Sa和Da分别是三个的alpha。
     // 明白了这些以后，就可以开始寻找我们所需要的blend模式了。
     kCGBlendModeClear,                          // R = 0
     kCGBlendModeCopy,                          // R = S
     kCGBlendModeSourceIn,                    // R = S*Da
     kCGBlendModeSourceOut,                 // R = S*(1 - Da)
     kCGBlendModeSourceAtop,               // R = S*Da + D*(1 - Sa)
     kCGBlendModeDestinationOver,         // R = S*(1 - Da) + D
     kCGBlendModeDestinationIn,             // R = D*Sa
     kCGBlendModeDestinationOut,          // R = D*(1 - Sa)
     kCGBlendModeDestinationAtop,        // R = S*(1 - Da) + D*Sa
     kCGBlendModeXOR,                          // R = S*(1 - Da) + D*(1 - Sa)
     kCGBlendModePlusDarker,                // R = MAX(0, (1 - D) + (1 - S))
     kCGBlendModePlusLighter                // R = MIN(1, S + D)
     */
    
    /** 说明
     用kCGBlendModeOverlay能保留灰度信息，用kCGBlendModeDestinationIn能保留透明度信息，因此在imageWithBlendMode方法中两次执行drawInRect:blendMode:alpha:方法实现我们绘制图片的基本需求。
     因为每次使用UIImage+tint的方法绘图时，都使用了CG的绘制方法，这就意味着每次调用都会是用到CPU的离屏渲染（Offscreen drawing），大量使用的话可能导致性能的问题。
     对于这里的UIImage+tint的实现，可以写一套缓存的机制，来确保大量重复的元素只在load的时候blend一次，之后将其缓存在内存中以快速读取。这是一个权衡时间和空间的问题，正体现了编程之美。
     */
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    // 画笔沾取颜色
    [[UIColor mk_colorWithHex:hex alpha:alpha] setFill];
    // 绘制区域
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    // 第一次绘制，保留灰度
    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    // 第二次绘制，保留透明度
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    // 获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *)mk_redrawWithScale:(CGFloat)scale {
    CGSize redrawSize = CGSizeMake(self.size.width * scale, self.size.height * scale);
    
    UIGraphicsBeginImageContext(redrawSize);
    [self drawInRect:CGRectMake(0, 0, redrawSize.width, redrawSize.height)];
    UIImage *redrawImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return redrawImage;
}

- (UIImage *)mk_redrawWithSize:(CGSize)size {
    // 开启一个图形上下文，并设为当前
    /* 参数说明
     size：区域大小
     opaqua：是否是非透明的（如果需要显示半透明效果，传NO；否则传YES）
     scale：屏幕密度
     */
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    // 重新绘制图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前图形上下文中读取新图片
    UIImage *redrawImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return redrawImage;
}

- (NSString *)mk_base64String {
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}


#pragma mark - 待验证API（来自网络）


/// 图片等比缩放，生成新图片
/// @param targetSize 目标尺寸
/// @param sourceImage 原图片
- (UIImage *) imageByScalingProportionallyToSize:(CGSize)targetSize sourceImage:(UIImage *)sourceImage {
    
    UIGraphicsBeginImageContext(targetSize);
    [sourceImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


/// 按新尺寸裁剪图片
/// @param targetSize 目标尺寸
/// @param sourceImage 原图片
- (UIImage*) imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage *) sourceImage {
    //    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)generatePhotoThumbnail:(UIImage *)image {
    // Create a thumbnail version of the image for the event object.
    CGSize size = image.size;
    CGSize croppedSize;
    CGFloat ratio = 64.0;//这个是设置转换后图片的尺寸大小
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
    
    // check the size of the image, we want to make it
    // a square with sides the size of the smallest dimension
    if (size.width > size.height) {
        offsetX = (size.height - size.width) / 2;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height) / 2;
        croppedSize = CGSizeMake(size.width, size.width);
    }
    
    // Crop the image before resize
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    //裁剪图片
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
    // Done cropping
    
    // Resize the image
    CGRect rect = CGRectMake(0.0, 0.0, ratio, ratio);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Done Resizing
    
    return thumbnail;
}


@end
