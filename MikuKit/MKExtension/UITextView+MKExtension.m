//
//  UITextView+MKExtension.m
//  FeOAClient
//
//  Created by jun on 2017/12/29.
//  Copyright © 2017年 flyrise. All rights reserved.
//

#import "UITextView+MKExtension.h"

@implementation UITextView (MKExtension)

- (void)mk_setPlaceholder:(NSString *)placeholder
                     font:(UIFont *)font
                    color:(UIColor *)color {
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholder;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = color;
    [self addSubview:placeHolderLabel];
    placeHolderLabel.font = font;
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}

@end
