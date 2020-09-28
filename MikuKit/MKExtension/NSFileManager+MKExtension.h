//
//  NSFileManager+MKExtension.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NSFileManagerResult) {
    NSFileManagerResultSucceed                  = 0,    // 操作成功
    NSFileManagerResultFailed                   = 1,    // 操作失败
    NSFileManagerResultFileAlreadyExist         = 2,    // 文件已存在
    NSFileManagerResultFileDoesNotExist         = 3,    // 文件不存在
    NSFileManagerResultDirectoryAlreadyExist    = 4,    // 文件夹已存在
    NSFileManagerResultDirectoryDoesNotExist    = 5,    // 文件夹不存在
};

@interface NSFileManager (MKExtension)

+ (NSFileManagerResult)mk_creatDirectoryWithPath:(NSString *)path;

+ (NSFileManagerResult)mk_deleteDirectoryWithPath:(NSString *)path;

+ (NSFileManagerResult)mk_renameDirectoryWithPath:(NSString *)path newName:(NSString *)newName;

+ (NSFileManagerResult)mk_moveDirectoryWithPath:(NSString *)originalPath toPath:(NSString *)targetPath;


@end

NS_ASSUME_NONNULL_END
