//
//  MCBounds.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCBounds.h"

@implementation MCBounds

+ (CGFloat)screenH{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)screenW{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenScale {
    return [UIScreen mainScreen].scale;
}

+ (CGFloat)statusBarH{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)navH{
    return 44.f;
}

+ (CGFloat)statusAndNavH{
    return [self statusBarH] + [self navH];
}

+ (CGFloat)mainViewH {
    return [self screenH] - [self statusAndNavH] - [self tabbarH];
}


+ (CGFloat)iPhoneXBottom{
    //if (GP_ISPhoneX) return 34;
    if (IPHONE_X) return 34;
    return 0;
}

+ (CGFloat)tabbarH {
    //if (GP_ISPhoneX) return [self iPhoneXBottom] + 49.f;
    if (IPHONE_X) return [self iPhoneXBottom] + 49.f;
    return 49.f;
}

+ (CGFloat)appW{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)appH{
    return [UIScreen mainScreen].bounds.size.height;
}

@end
