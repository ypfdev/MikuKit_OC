//
//  MCTipsUtils+ErrorCode.h
//  MotionCamera
//
//  Created by 原鹏飞 on 7/8/20.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCTipsUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCTipsUtils (ErrorCode)

+ (void)showErrorTipsWithCode:(MCCode)errorCode completionHandler:(void (^ __nullable)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
