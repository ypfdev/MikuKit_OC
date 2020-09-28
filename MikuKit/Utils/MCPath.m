//
//  MCPath.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/12/30.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCPath.h"

@implementation MCPath

+ (NSString *)downloadListCache {
    NSString *directoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [directoryPath stringByAppendingString:@"/downloadList.plist"];
    return filePath;
}

@end
