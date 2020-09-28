//
//  CALayer+MKExtension.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/27.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "CALayer+MKExtension.h"

@implementation CALayer (MKExtension)

- (void)mk_borderWithColor:(UIColor *)color width:(CGFloat)width {
    self.borderColor = color.CGColor;
    self.borderWidth = width;
}

- (void)mk_debugBorderWithColor:(UIColor *)color width:(CGFloat)width {
#if Debug_Apeman || Debug_Crosstour || Debug_Victure
//#if DEBUG
    self.borderColor = color.CGColor;
    self.borderWidth = width;
#endif
}

@end
