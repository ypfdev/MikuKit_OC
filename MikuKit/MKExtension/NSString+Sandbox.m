//
//  NSString+Sandbox.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "NSString+Sandbox.h"

@implementation NSString (Sandbox)

+ (NSString *)mk_homePath {
    return NSHomeDirectory();
}

+ (NSString *)mk_documentPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)mk_cachePath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)mk_libarayPath {
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)mk_tmpPath {
    return NSTemporaryDirectory();
}

@end
