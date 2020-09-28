//
//  NSString+Hash.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/12/12.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Hash)

@property (readonly) NSString *mk_MD5String;
@property (readonly) NSString *mk_sha1String;
@property (readonly) NSString *mk_sha256String;
@property (readonly) NSString *mk_sha512String;

- (NSString *)mk_hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)mk_hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)mk_hmacSHA512StringWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
