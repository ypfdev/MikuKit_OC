//
//  NSData+AES256.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/10/24.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AES256)

- (NSData *)mk_encrypt_aes256:(NSString *)key;
- (NSData *)mk_decrypt_aes256:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
