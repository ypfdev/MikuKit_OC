//
//  MKDiskCache.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/10/31.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MKDiskCache.h"

// 定义key，对应的Object是MKDiskCache中保存localIdentifier的字典
static NSString * const localIdentifierCache = @"localIdentifierDict";

// 定义key，对应的Object是MKDiskCache中保存message模型的数组
static NSString * const messageCache = @"messageArrM";

@implementation MKDiskCache

#pragma mark - Initializer

/// Singleton
+ (instancetype)sharedCache {
    static MKDiskCache *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        // 拼接缓存文件路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/MKDiskCache"];
        // 根据路径创建磁盘缓存管理对象
        _sharedInstance = [[self alloc] initWithPath:path];
    });

    return _sharedInstance;
}

#pragma mark - Album Medium LocalIdentifier Cache

+ (instancetype)localIdentifierCache {
    MKDiskCache *cache = [MKDiskCache sharedCache];
    if (![cache containsObjectForKey:localIdentifierCache]) {
        NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[NSMutableDictionary new];
        [cache setObject:dict forKey:localIdentifierCache];
    }
    return cache;
}

- (NSUInteger)totalIdentifierCount {
    MKDiskCache *diskCache = [MKDiskCache localIdentifierCache];
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[diskCache objectForKey:localIdentifierCache];
    return dict.count;
    
}

- (BOOL)containsIdentifier:(NSString *)identifier {
    MKDiskCache *diskCache = [MKDiskCache localIdentifierCache];
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[diskCache objectForKey:localIdentifierCache];
    return [dict.allValues containsObject:identifier];
}

- (BOOL)containsIdentifierForKey:(NSString *)key; {
    MKDiskCache *diskCache = [MKDiskCache localIdentifierCache];
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[diskCache objectForKey:localIdentifierCache];
    return [dict.allKeys containsObject:key];
}

- (nullable NSString *)identifierForKey:(NSString *)key {
    MKDiskCache *diskCache = [MKDiskCache localIdentifierCache];
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[diskCache objectForKey:localIdentifierCache];
    if ([dict.allKeys containsObject:key]) {
        return [dict objectForKey:key];
    }
    return nil;
}

- (NSString *)keyOfIdentifier:(NSString *)identifier {
    MKDiskCache *diskCache = [MKDiskCache localIdentifierCache];
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[diskCache objectForKey:localIdentifierCache];
    __block NSString *keyStr;
    [dict.allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger keyIndex, BOOL * _Nonnull stop) {
        if ([[dict objectForKey:key] isEqualToString:identifier]) {
            keyStr = key;
        }
    }];
    return keyStr;
}

- (void)addIdentifier:(NSString *)identifier forKey:(NSString *)key {
    MKDiskCache *diskCache = [MKDiskCache localIdentifierCache];
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[diskCache objectForKey:localIdentifierCache];
    [dict setObject:identifier forKey:key];
    [diskCache setObject:dict forKey:localIdentifierCache];
}

- (void)removeIdentifierForKey:(NSString *)key {
    MKDiskCache *diskCache = [MKDiskCache localIdentifierCache];
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[diskCache objectForKey:localIdentifierCache];
    if ([dict.allKeys containsObject:key]) {
        [dict removeObjectForKey:key];
        [diskCache setObject:dict forKey:localIdentifierCache];
    }
}

- (void)removeIdentifier:(NSString *)identifier {
    MKDiskCache *diskCache = [MKDiskCache localIdentifierCache];
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[diskCache objectForKey:localIdentifierCache];
    if ([dict.allValues containsObject:identifier]) {
        [dict.allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger keyIndex, BOOL * _Nonnull stop) {
            if ([[dict objectForKey:key] isEqualToString:identifier]) {
                [dict removeObjectForKey:key];
                *stop = YES;
            }
        }];
        [diskCache setObject:dict forKey:localIdentifierCache];
    }
}

- (void)removeAllIdentifiers {
    MKDiskCache *diskCache = [MKDiskCache localIdentifierCache];
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[diskCache objectForKey:localIdentifierCache];
    if (dict.count > 0) {
        [dict removeAllObjects];
        [diskCache setObject:dict forKey:localIdentifierCache];
    }
}


#pragma mark - UMeng Message Cache

/// 管理友盟推送消息缓存的单例
+ (instancetype)messageCache {
    MKDiskCache *cache = [MKDiskCache sharedCache];
    if (![cache containsObjectForKey:messageCache]) {
        NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *messageArrM = (NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *)[NSMutableArray new];
        [cache setObject:messageArrM forKey:messageCache];
    }
    return cache;
}

- (void)addMessage:(MCMessage *)message {
    // 取出缓存
    MKDiskCache *diskCache = [MKDiskCache messageCache];
    NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *messageArrM = (NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *)[diskCache objectForKey:messageCache];
    // 新建字典并写入信息
    NSMutableDictionary<NSString *, NSString *> *dict = (NSMutableDictionary<NSString *, NSString *> *)[NSMutableDictionary new];
//    [dict setObject:message.msgID forKey:@"msgID"];
//    [dict setObject:message.title forKey:@"title"];
//    [dict setObject:message.subTitle forKey:@"subTitle"];
//    [dict setObject:message.body forKey:@"body"];
//    [dict setObject:message.date forKey:@"date"];
    [dict setObject:@"NO" forKey:@"readFlag"];
    // 将字典插入数组最前端
    [messageArrM insertObject:dict atIndex:0];
    // 更新缓存
    [diskCache setObject:messageArrM forKey:messageCache];
    // 发送收到新消息的通知（如果在消息列表页面，就刷新列表）
    [[NSNotificationCenter defaultCenter] postNotificationName:MCMessageReceivedNewNotification object:message];
}

- (void)readMessage:(MCMessage *)message {
    // 取出缓存
    MKDiskCache *diskCache = [MKDiskCache messageCache];
    NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *messageArrM = (NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *)[diskCache objectForKey:messageCache];
    // 找到缓存元素并修改值
//    [messageArrM enumerateObjectsUsingBlock:^(NSMutableDictionary<NSString *,NSString *> * _Nonnull msg, NSUInteger msgIndex, BOOL * _Nonnull stop) {
//        if ([message.msgID isEqualToString:[msg objectForKey:@"msgID"]]) {
//            message.readFlag = YES;
//            [msg setObject:@"YES" forKey:@"readFlag"];
//        }
//    }];
    // 更新缓存
    [diskCache setObject:messageArrM forKey:messageCache];
}

- (void)removeAllMessages {
    // 取出缓存
    MKDiskCache *diskCache = [MKDiskCache messageCache];
    NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *messageArrM = (NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *)[diskCache objectForKey:messageCache];
    // 移出全部
    [messageArrM removeAllObjects];
    // 更新缓存
    [diskCache setObject:messageArrM forKey:messageCache];
}

- (NSMutableArray<MCMessage *> *)msgArrM {
    // 取出缓存
    MKDiskCache *diskCache = [MKDiskCache messageCache];
    NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *messageArrM = (NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *)[diskCache objectForKey:messageCache];
    // 新建临时容器
    NSMutableArray<MCMessage *> *msgArrM = (NSMutableArray<MCMessage *> *)[NSMutableArray new];
    // 根据缓存创建消息模型对象，并放入临时容器
    [messageArrM enumerateObjectsUsingBlock:^(NSMutableDictionary<NSString *,NSString *> * _Nonnull message, NSUInteger messageIndex, BOOL * _Nonnull stop) {
//        MCMessage *msg = [MCMessage messageWithMsgID:[message objectForKey:@"msgID"]
//                                               title:[message objectForKey:@"title"]
//                                            subTitle:[message objectForKey:@"subTitle"]
//                                                body:[message objectForKey:@"body"]];
//        msg.readFlag = [[message objectForKey:@"readFlag"] isEqualToString:@"YES"] ? YES : NO;
//        [msgArrM addObject:msg];
    }];
    // 返回
    return msgArrM;
}

- (NSInteger)unreadMsgCount {
    __block NSInteger count = 0;
    // 取出缓存
    MKDiskCache *diskCache = [MKDiskCache messageCache];
    NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *messageArrM = (NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *)[diskCache objectForKey:messageCache];
    // 统计未读消息数量
    if (messageArrM.count == 0) {
        return 0;
    }
    [messageArrM enumerateObjectsUsingBlock:^(NSMutableDictionary<NSString *,NSString *> * _Nonnull message, NSUInteger messageIndex, BOOL * _Nonnull stop) {
        if ([[message objectForKey:@"readFlag"] isEqualToString:@"NO"]) {
            count += 1;
        }
    }];
    return count;
}

- (NSInteger)totalGroupCount {
    // 取出缓存
    MKDiskCache *diskCache = [MKDiskCache messageCache];
    NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *messageArrM = (NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *)[diskCache objectForKey:messageCache];
    if (messageArrM.count == 0) {
        return 0;
    }
    // 将全部日期取出，放到一个数组中
    NSMutableArray<NSString *> *dateArrM = [NSMutableArray new];
    [messageArrM enumerateObjectsUsingBlock:^(NSMutableDictionary<NSString *,NSString *> * _Nonnull message, NSUInteger messageIndex, BOOL * _Nonnull stop) {
         [dateArrM addObject:[message objectForKey:@"date"]];
    }];
    // 数组去重
    dateArrM = [[NSSet setWithArray:dateArrM] allObjects].mutableCopy;
//    // 排序
//    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];
//    // 如果有多个descriptor（多重排序），则先按第0个排序，再按第1个...依次类推
//    [dateArrM sortUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    return dateArrM.count;
}

- (NSInteger)totalMessageCounthWitDate:(NSString *)date {
    // 取出缓存
    MKDiskCache *diskCache = [MKDiskCache messageCache];
    NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *messageArrM = (NSMutableArray<NSMutableDictionary<NSString *, NSString *> *> *)[diskCache objectForKey:messageCache];
    // 计算个数
    __block NSInteger count = 0;
    [messageArrM enumerateObjectsUsingBlock:^(NSMutableDictionary<NSString *,NSString *> * _Nonnull msg, NSUInteger msgIndex, BOOL * _Nonnull stop) {
        if ([date isEqualToString:[msg objectForKey:@"date"]]) {
            count += 1;
        }
    }];
    return count;
}

@end
