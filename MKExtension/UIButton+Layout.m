//
//  UIButton+Layout.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/7.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "UIButton+Layout.h"

@implementation UIButton (Layout)

- (void)verticalAlignButtonWithSpacing:(CGFloat)spacing {
    NSString *titleString = [self titleForState:UIControlStateNormal]?:@"";
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:titleString attributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGSize titleSize = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    CGFloat maxImageHeight = CGRectGetHeight(self.frame) - titleSize.height - spacing * 2;
    CGFloat maxImageWidth = CGRectGetWidth(self.frame);
    UIImage *newImage = nil;
    if (imageSize.width > ceilf(maxImageWidth)) {
        CGFloat ratio = maxImageWidth / imageSize.width;
        newImage = [self scaledImageWithImage:self.imageView.image size:CGSizeMake(maxImageWidth, imageSize.height * ratio)];
        imageSize = newImage.size;
    }
    if (imageSize.height > ceilf(maxImageHeight)) {
        CGFloat ratio = maxImageHeight / imageSize.height;
        newImage = [self scaledImageWithImage:self.imageView.image size:CGSizeMake(imageSize.width * ratio, maxImageHeight)];
        imageSize = newImage.size;
    }
    if (newImage) {
        if ([newImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
            newImage = [newImage imageWithRenderingMode:self.imageView.image.renderingMode];
        }
        [self setImage:newImage forState:UIControlStateNormal];
    }

    CGFloat imageVerticalDiff = titleSize.height + spacing;
    CGFloat imageHorizontalDiff = titleSize.width;

    self.imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalDiff, 0, 0, -imageHorizontalDiff);

    CGFloat titleVerticalDiff = imageSize.height + spacing;
    CGFloat titleHorizontalDiff = imageSize.width;

    self.titleEdgeInsets = UIEdgeInsetsMake(0, -titleHorizontalDiff, -titleVerticalDiff, 0);
}

- (void)horizontalAlignButtonWithSpacing:(CGFloat)spacing yOffset:(CGFloat)offset {
    NSString *titleString = [self titleForState:UIControlStateNormal]?:@"";
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:titleString attributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGSize titleSize = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;

    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    
    CGFloat titleHorizontalDiff = imageSize.width;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(offset, -titleHorizontalDiff - spacing * 2, 0, 0);
    
    CGFloat imageHorizontalDiff = titleSize.width;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(offset, imageHorizontalDiff + spacing * 0.5, 0, -imageHorizontalDiff - spacing * 0.5);
}

- (void)mk_resetButton_titleLeftImageRight {
    /** 原理
     uibutton默认是左图片，右文字。并且在设置edge insets之前，位置已经有了设定。所以设置title的edge insets，真实的作用是在原来的边距值基础上增加或减少某个间距，负值便是减少。以title为例，设置右边距增加图片宽度，就使得自己的右边界距离按钮的右边界多了图片的宽度，正好放下图片。此时，title lable变小了，而title lable的左边界还在原来的位置上，所以lable的左边界距离按钮的左边界减少图片的宽度，lable就和原来一样大了，而且左侧起始位置和图片的左侧起始位置相同了
     */
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - self.imageView.bounds.size.width, 0, self.imageView.bounds.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, - self.titleLabel.bounds.size.width)];
}

- (void)mk_resetButton:(UIButton*)btn {
    //使图片和文字水平居中显示
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //调整文本框位置
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height * 1.3, - btn.imageView.frame.size.width, 0, 0)];
    //设置文字
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setAdjustsFontSizeToFitWidth:NO];
    //调整图片位置
    [btn setImageEdgeInsets:UIEdgeInsetsMake(- btn.titleLabel.bounds.size.height * 1.3, 0, 0, - btn.titleLabel.bounds.size.width)];
}

- (void)mk_resetButton {
    // 使图片和文字水平居中显示
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    // 调整文本框位置
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height * 1.3, - self.imageView.frame.size.width, 0, 0)];
    // 设置文字
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleLabel setAdjustsFontSizeToFitWidth:NO];
    // 调整图片位置
    [self setImageEdgeInsets:UIEdgeInsetsMake(- self.titleLabel.bounds.size.height * 1.3, 0, 0, - self.titleLabel.bounds.size.width)];
}

- (void)mk_resetButtonDisable {
    // 使图片和文字水平居中显示
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //调整文本框位置
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height * 1.3, - self.imageView.frame.size.width, 0, 0)];
    //设置文字
    [self setTitleColor:[UIColor mk_colorWithRed:175 green:175 blue:175] forState:UIControlStateNormal];
    [self.titleLabel setAdjustsFontSizeToFitWidth:NO];
    //调整图片位置
    [self setImageEdgeInsets:UIEdgeInsetsMake(- self.titleLabel.bounds.size.height * 1.3, 0, 0, - self.titleLabel.bounds.size.width)];
}

//+ (instancetype)mk_Button:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor defaultImage:(UIimage *)defaultImage selectImage:(UIImage *)selectImage {
//
//    UIButton *button = [[self alloc] init];
//
//    [button setTitle:title forState:UIControlStateNormal];
//
//    [button setTitleColor:normalColor forState:UIControlStateNormal];
//    [button setTitleColor:selectedColor forState:UIControlStateSelected];
//
//    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
//
//    [button sizeToFit];
//
//    button.imageView = [UIImageView alloc] initWithImage:<#(nullable UIImage *)#>
    
//    return button;
//}

#pragma mark - 辅助方法

- (UIImage *)scaledImageWithImage:(UIImage *)image size:(CGSize)size {
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    // 设置绘制图片相关参数
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    // 绘制图片
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), image.CGImage);
    // 获取图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();

    return scaledImage;
}

@end
