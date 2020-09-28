//
//  NSString+Sandbox.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Sandbox)

+ (NSString *)mk_homePath;
+ (NSString *)mk_documentPath;
+ (NSString *)mk_cachePath;
+ (NSString *)mk_libarayPath;
+ (NSString *)mk_tmpPath;

@end

NS_ASSUME_NONNULL_END
