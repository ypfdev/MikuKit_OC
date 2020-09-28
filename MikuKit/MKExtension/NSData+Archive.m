//
//  NSData+Archive.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/12/11.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "NSData+Archive.h"

@implementation NSData (Archive)

- (void)mk_archiveObject:(nullable id)object forKey:(NSString *)key {
    // 新建一块可变数据区
    NSMutableData *data = [NSMutableData data];

    // 将数据区连接到一个NSKeyedArchiver对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];

    // 开始存档对象，存档的数据都会存储到NSMutableData中
    [archiver encodeObject:object forKey:key];

    // 存档完毕(一定要调用这个方法)
    [archiver finishEncoding];
}


- (void)mk_unarchiveFilePath:(NSString *)filePath {
    // 从文件中读取数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];

    // 根据数据，解析成一个NSKeyedUnarchiver对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    Person *person1 = [unarchiver decodeObjectForKey:@"person1"];
    
    // 恢复完毕
    [unarchiver finishDecoding];
}

@end
