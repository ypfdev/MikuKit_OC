//
//  MCKeyChainTool.h
//  MotionCamera
//
//  Created by YPFdeMBP15 on 2020/6/3.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString * const AppKeychainService;

@interface MCKeyChainTool : NSObject

+ (NSError *)saveKeychainWithService:(NSString *)service
                             account:(NSString *)account
                            password:(NSString *)password;

+ (NSError *)deleteWithService:(NSString *)service
                       account:(NSString *)account;

+ (NSError *)updateKeychainWithService:(NSString *)service
                               account:(NSString *)account
                              password:(NSString *)password;

+ (NSError *)queryKeychainWithService:(NSString *)service
                              account:(NSString *)account;

@end

NS_ASSUME_NONNULL_END
