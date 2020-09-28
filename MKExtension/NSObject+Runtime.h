//
//  NSObject+Runtime.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/9/9.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime)

- (NSArray<NSString *> *)mk_propertyNameList;

@end

NS_ASSUME_NONNULL_END
