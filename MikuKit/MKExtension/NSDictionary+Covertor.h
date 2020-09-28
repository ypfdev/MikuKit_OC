//
//  NSDictionary+Covertor.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2018/11/29.
//  Copyright © 2018 Galanz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Covertor)

/// json字符串转字典
/// @param jsonStr 待处理json字符串
+ (NSDictionary *)mk_dictionaryWithJsonString:(NSString *)jsonStr;

@end

NS_ASSUME_NONNULL_END
