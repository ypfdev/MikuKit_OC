//
//  UILabel+MKExtension.m
//  MotionCamera
//
//  Created by Kimee on 2018/10/27.
//  Copyright © 2018 Galanz. All rights reserved.
//

#import "UILabel+MKExtension.h"

@implementation UILabel (MKExtension)

+ (instancetype)mk_labelWithText:(NSString *)text
                       textColor:(UIColor *)textColor
                            font:(UIFont *)font {
    UILabel* label = [UILabel new];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}

/**
 快速创建标签
 
 @param text 标签文字
 @param hexStr 文字颜色的Hex字符串
 @param fontName 字体名称
 @param fontSize 字体字号
 @return 标签
 */
+ (instancetype)mk_labelWithText:(nullable NSString * )text textColorHexStr:(NSString *)hexStr fontName:(NSString *)fontName fontSize:(CGFloat)fontSize {
    UILabel* label = [UILabel new];
    label.text = text;
    label.textColor = [UIColor mk_colorWithHexString:hexStr];
    label.font = [UIFont fontWithName:fontName size:fontSize];
    
    return label;
}


/**
 快速创建带边框的标签
 
 @param text 标签文字
 @param hexStr 文字颜色的Hex字符串
 @param fontName 字体名称
 @param fontSize 字体字号
 @return 标签
 */
+ (instancetype)gp_labelWithText:(nullable NSString * )text textColorHexStr:(NSString *)hexStr fontName:(NSString *)fontName fontSize:(CGFloat)fontSize borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    UILabel* label = [UILabel new];
    label.text = text;
    label.textColor = [UIColor mk_colorWithHexString:hexStr];
    label.font = [UIFont fontWithName:fontName size:fontSize];
    label.layer.borderWidth = width;
    label.layer.borderColor = color.CGColor;
    
    return label;
}


/**
 快速创建类方法
 
 @param text 标签文字
 @param hexStr 标签颜色的十六进制字符串
 @param size 标签文字字号
 @return 标签
 */
+ (instancetype)gp_labelWithText:(NSString *)text textColorHexStr:(NSString *)hexStr fontSize:(CGFloat)size {
    UILabel* label = [UILabel new];
    label.text = text;
    label.textColor = [UIColor mk_colorWithHexString:hexStr];
    label.font = [UIFont systemFontOfSize:size];
    return label;
}


/**
 快速创建类方法
 
 @param text 标签文字
 @param color 标签颜色
 @param size 标签文字字号
 @return 标签
 */
+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)size{
    UILabel* label = [UILabel new];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:size * SizeScale];
    label.numberOfLines = 0;
    return label;
}


/**
 重置文字对齐方式：两边对齐
 */
- (void)mk_resetTextAlignmentRightandLeft {
    
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil];
    
    CGFloat margin = (self.frame.size.width - textSize.size.width) / (self.text.length - 1);
    
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributeString addAttribute:NSKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attributeString;
}


/**
 重置文字对齐方式：两边对齐，特定行距
 
 @param lineSpacing 行距
 */
- (void)mk_resetTextAlignmentLeftRightWithlineSpacing:(CGFloat)lineSpacing {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 设置行距
    [paragraphStyle setLineSpacing:lineSpacing];
    // 文本对齐方式 左右对齐（两边对齐）
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSString *text = self.text ?: @"";
    // 设置富文本
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置段落样式
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    // 设置字体大小
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    // 这段话必须要添加，否则UIlabel两边对齐无效 NSUnderlineStyleAttributeName （设置下划线）
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}


///**
// 左上对齐
// */
//- (void)gp_textAlignmentLeftTop {
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f], NSParagraphStyleAttributeName:paragraphStyle.copy};
//
//    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//
//    CGRect dateFrame =CGRectMake(2, 140, CGRectGetWidth(self.frame)-5, labelSize.height);
//    self.frame = dateFrame;
//}


//- (void)textAlignmentTop {
//    CGSize fontSize = [self.text sizeWithFont:self.font];
//
//    double finalHeight = fontSize.height * self.numberOfLines;
//    double finalWidth = self.frame.size.width;    //expected width of label
//
//    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
//
//    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
//
//    for(int i=0; i<= newLinesToPad; i++) {
//        self.text = [self.text stringByAppendingString:@" \n"];
//    }
//}
//
//- (void)textAlignmentBottom {
//    CGSize fontSize = [self.text sizeWithFont:self.font];
//
//    double finalHeight = fontSize.height * self.numberOfLines;
//    double finalWidth = self.frame.size.width;    //expected width of label
//
//    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
//
//    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
//
//    for(int i=0; i< newLinesToPad; i++) {
//        self.text = [NSString stringWithFormat:@" \n%@",self.text];
//    }
//}


@end
