//
//  NSString+Additions.m
//  MotionCamera
//
//  Created by 青狼 on 2020/5/14.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)
NSString *safeString(NSString *str)
{
    if ([str isKindOfClass:[NSNull class]] || str == nil) {
        return @"";
    }
    return str;
}
@end
