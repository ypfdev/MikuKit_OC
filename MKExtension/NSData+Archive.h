//
//  NSData+Archive.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/12/11.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Archive)

- (void)mk_archiveObject:(nullable id)object forKey:(NSString *)key;
- (void)mk_unarchiveFilePath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
