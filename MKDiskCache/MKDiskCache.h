//
//  MKDiskCache.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/10/31.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "YYDiskCache.h"
#import "MCMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKDiskCache : YYDiskCache


#pragma mark - Initializer

// 自身的创建单例方法在各个缓存管理器中调用，不对外开放

// MARK: 禁止外部调用
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE;          // 没有遵循协议可以不写
- (id)mutableCopy NS_UNAVAILABLE;   // 没有遵循协议可以不写

#pragma mark - Album Medium LocalIdentifier Cache

@property (nonatomic, assign) NSUInteger totalIdentifierCount;

/// 管理手机相册localIdentifier缓存的单例
+ (instancetype)localIdentifierCache;

- (NSUInteger)totalIdentifierCount;

- (BOOL)containsIdentifier:(NSString *)identifier;
- (BOOL)containsIdentifierForKey:(NSString *)key;

- (nullable NSString *)identifierForKey:(NSString *)key;
- (NSString *)keyOfIdentifier:(NSString *)identifier;

- (void)addIdentifier:(NSString *)identifier forKey:(NSString *)key;

- (void)removeIdentifierForKey:(NSString *)key;
- (void)removeIdentifier:(NSString *)identifier;
- (void)removeAllIdentifiers;

#pragma mark - UMeng Message Cache

/// 管理友盟推送消息缓存的单例
+ (instancetype)messageCache;

- (void)addMessage:(MCMessage *)message;
- (void)readMessage:(MCMessage *)message;
- (void)removeAllMessages;

- (NSMutableArray<MCMessage *> *)msgArrM;
- (NSInteger)unreadMsgCount;
- (NSInteger)totalGroupCount;
- (NSInteger)totalMessageCounthWitDate:(NSString *)date;

@end

NS_ASSUME_NONNULL_END
