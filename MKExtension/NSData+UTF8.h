//
//  NSData+UTF8.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/2/27.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (UTF8)

- (NSString *)mk_utf8String;
- (NSData *)mk_utf8Data;

@end

NS_ASSUME_NONNULL_END
