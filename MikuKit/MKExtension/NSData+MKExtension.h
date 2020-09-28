//
//  NSData+MKExtension.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/2/26.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (MKExtension)

/// 剔除非utf-8的字符
/// @param data 待处理的NSData
- (NSData *)mk_cleanUTF8:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
