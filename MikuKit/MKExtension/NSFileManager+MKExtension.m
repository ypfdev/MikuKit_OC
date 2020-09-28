//
//  NSFileManager+MKExtension.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "NSFileManager+MKExtension.h"

@implementation NSFileManager (MKExtension)

+ (NSFileManagerResult)mk_creatDirectoryWithPath:(NSString *)path {
    /** 注意
     创建新文件夹时，要确保上一级路径已经存在
     */
    
    BOOL isDirectoryFlag = NO;
    BOOL isExitFlag = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectoryFlag];
    
    if (isExitFlag == YES && isDirectoryFlag == YES) {
        // 文件夹已存在
        return NSFileManagerResultDirectoryAlreadyExist;
    }
    
    // 创建文件夹
    NSError *error;
    BOOL resultFlag = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if (resultFlag) {
        return NSFileManagerResultSucceed;
    } else {
        PFLog(@"error = %@", error);
        return NSFileManagerResultFailed;
    }
}


+ (NSFileManagerResult)mk_deleteDirectoryWithPath:(NSString *)path {
    BOOL isDirectoryFlag = NO;
    BOOL isExistFlag = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectoryFlag];
    
    if (isExistFlag == NO || isDirectoryFlag == NO) {
        return NSFileManagerResultDirectoryDoesNotExist;
    }
    
    // 删除文件夹
    NSError *error;
    BOOL resultFlag = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (resultFlag) {
        return NSFileManagerResultSucceed;
    } else {
        PFLog(@"error = %@", error);
        return NSFileManagerResultFailed;
    }
}





+ (NSFileManagerResult)mk_renameDirectoryWithPath:(NSString *)path newName:(NSString *)newName {
    // 检查旧文件夹是否存在
    BOOL isOldDirectoryFlag = NO;
    BOOL isOldExitFlag = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isOldDirectoryFlag];
    if (isOldExitFlag == NO || isOldDirectoryFlag == NO) {
        return NSFileManagerResultFailed;
    }
    
    // 检查新名称是否已被占用
    NSString *newPath = [[path stringByDeletingLastPathComponent] stringByAppendingString:newName];
    BOOL isNewDirectoryFlag = NO;
    BOOL isNewExitFlag = [[NSFileManager defaultManager] fileExistsAtPath:newPath  isDirectory:&isNewDirectoryFlag];
    if (isNewExitFlag && isNewDirectoryFlag) {
        return NSFileManagerResultDirectoryAlreadyExist;
    }
    
    // 创建新文件夹
    BOOL creatNewFlag = [[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (creatNewFlag == NO) {
        return NSFileManagerResultFailed;
    }
    
    // 移动文件
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
    [enumerator.allObjects enumerateObjectsUsingBlock:^(NSString * _Nonnull subPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSFileManager defaultManager] moveItemAtPath:subPath toPath:newPath error:nil];
    }];
    
    // 删除旧文件夹
    NSError *error;
    BOOL resultFlag = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (resultFlag) {
        return NSFileManagerResultSucceed;
    } else {
        PFLog(@"error = %@", error);
        return NSFileManagerResultSucceed;
    }
}


/**
 移动文件夹

 @param originalPath 原路径（绝对路径）
 @param targetPath 目标路径（绝对路径）
 @return 操作结果
 */
+ (NSFileManagerResult)mk_moveDirectoryWithPath:(NSString *)originalPath toPath:(NSString *)targetPath {
    BOOL isDirectoryFlag = NO;
    BOOL isExitFlag = [[NSFileManager defaultManager] fileExistsAtPath:targetPath isDirectory:&isDirectoryFlag];
    
    if (isExitFlag && isDirectoryFlag) {
        return NSFileManagerResultDirectoryAlreadyExist;
    }
    
    NSError *error;
    BOOL resultFlag = [[NSFileManager defaultManager] moveItemAtPath:originalPath toPath:targetPath error:&error];
    if (resultFlag) {
        return NSFileManagerResultSucceed;
    } else {
        PFLog(@"error = %@", error);
        return NSFileManagerResultFailed;
    }
}


@end
