//
//  MCKeyChainTool.m
//  MotionCamera
//
//  Created by YPFdeMBP15 on 2020/6/3.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCKeyChainTool.h"
#import <Security/SecBase.h>
#import <Security/SecItem.h>

NSString * const QikeychainService = [NSString stringWithFormat:@"%@.keychain", [[NSBundle mainBundle] bundleIdentifier]];
static NSString* const keychainErrorDomain = [NSString stringWithFormat:@"%@.keychain.errorDomain", [[NSBundle mainBundle] bundleIdentifier]];
static NSInteger const kErrorCodeKeychainSomeArgumentsInvalid = 1000; //! 传入的部分参数无效

@implementation MCKeyChainTool

#pragma mark - Public

+ (NSError *)saveKeychainWithService:(NSString *)service account:(NSString *)account password:(NSString *)password {
    if (!account || !password || !service) {
        NSError *error = [self errorWithErrorCode:kErrorCodeKeychainSomeArgumentsInvalid];
        return error;
    }
    
    NSError *queryError = [self queryKeychainWithService:service account:account];
    // 如果已存在，就更新；否则，就保存
    if (queryError.code == errSecSuccess) {
        // update
        return [self updateKeychainWithService:service account:account password:password];
    }
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    // save
    NSDictionary *saveSecItems = @{(id)kSecClass: (id)kSecClassGenericPassword,
                                   (id)kSecAttrService: service,
                                   (id)kSecAttrAccount: account,
                                   (id)kSecValueData: passwordData
                               };
    OSStatus saveStatus = SecItemAdd((CFDictionaryRef)saveSecItems, NULL);
    return [self errorWithErrorCode:saveStatus];
}

+ (NSError *)deleteWithService:(NSString *)service account:(NSString *)account {
    if (!service || !account) {
        return [self errorWithErrorCode:kErrorCodeKeychainSomeArgumentsInvalid];
    }
    NSDictionary *deleteSecItems = @{
                                    (id)kSecClass: (id)kSecClassGenericPassword,
                                    (id)kSecAttrService: service,
                                    (id)kSecAttrAccount: account
                                    };
    OSStatus errorCode = SecItemDelete((CFDictionaryRef)deleteSecItems);
    return [self errorWithErrorCode:errorCode];
}

+ (NSError *)updateKeychainWithService:(NSString *)service account:(NSString *)account password:(NSString *)password {
    if (!account || !password || !service) {
        NSError *error = [self errorWithErrorCode:kErrorCodeKeychainSomeArgumentsInvalid];
        return error;
    }
    NSDictionary *queryItems = @{(id)kSecClass: (id)kSecClassGenericPassword,
                                 (id)kSecAttrService : service,
                                 (id)kSecAttrAccount : account};
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *updatedItems = @{(id)kSecValueData: passwordData};
    OSStatus updateStatus = SecItemUpdate((CFDictionaryRef)queryItems, (CFDictionaryRef)updatedItems);
    return [self errorWithErrorCode:updateStatus];
}

+ (NSError *)queryKeychainWithService:(NSString *)service account:(NSString *)account {
    if (!service || !account) {
        return [self errorWithErrorCode:kErrorCodeKeychainSomeArgumentsInvalid];
    }
    NSDictionary *matchSecItems = @{
                                    (id)kSecClass: (id)kSecClassGenericPassword,
                                    (id)kSecAttrService: service,
                                    (id)kSecAttrAccount: account,
                                    (id)kSecMatchLimit: (id)kSecMatchLimitOne,
                                    (id)kSecReturnData: @(YES)
                                    };
    CFTypeRef dataRef = nil;
    OSStatus errorCode = SecItemCopyMatching((CFDictionaryRef)matchSecItems, (CFTypeRef *)&dataRef);
    if (errorCode == errSecSuccess) {
        NSString *password = [[NSString alloc] initWithData:CFBridgingRelease(dataRef) encoding:NSUTF8StringEncoding];
        return [self errorWithErrorCode:errSecSuccess errorMessage:password];
    }
    return [self errorWithErrorCode:errorCode];
}

#pragma mark - Private

+ (NSError *)errorWithErrorCode:(OSStatus)errorCode {
    NSString *errorMsg = nil;
    switch (errorCode) {
        case errSecSuccess: {
            NSLog(@"%s--Line:%d--错误码：%d--错误信息：%@", __FUNCTION__, __LINE__, errorCode, errorMsg);
            return nil;
            break;
        }
        case kErrorCodeKeychainSomeArgumentsInvalid:
            errorMsg = NSLocalizedString(@"参数无效", nil);
            break;
        case errSecDuplicateItem: // -25299
            errorMsg = NSLocalizedString(@"The specified item already exists in the keychain. ", nil);
            break;
        case errSecItemNotFound: // -25300
            errorMsg = NSLocalizedString(@"The specified item could not be found in the keychain. ", nil);
            break;
        default: {
            if (@available(iOS 11.3, *)) {
                errorMsg = (__bridge_transfer NSString *)SecCopyErrorMessageString(errorCode, NULL);
            }
            break;
        }
    }
    NSDictionary *errorUserInfo = nil;
    if (errorMsg) {
        errorUserInfo = @{NSLocalizedDescriptionKey: errorMsg};
        NSLog(@"%s--Line:%d--错误码：%d--错误信息：%@", __FUNCTION__, __LINE__, errorCode, errorMsg);
    }
    
    return [NSError errorWithDomain:keychainErrorDomain code:kErrorCodeKeychainSomeArgumentsInvalid userInfo:errorUserInfo];
}

+ (NSError *)errorWithErrorCode:(OSStatus)errCode errorMessage:(NSString *)errorMsg {
    if (errCode == errSecSuccess && errorMsg) {
        NSLog(@"%s--Line:%d--错误码：%d--错误信息：%@", __FUNCTION__, __LINE__, errSecSuccess, errorMsg);
        return [NSError errorWithDomain:keychainErrorDomain code:errSecSuccess userInfo:@{NSLocalizedDescriptionKey: errorMsg}];
    } else {
        return [self errorWithErrorCode:errCode];
    }
}

@end
