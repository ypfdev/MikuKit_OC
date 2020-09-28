//
//  MCTipsUtils+ErrorCode.m
//  MotionCamera
//
//  Created by 原鹏飞 on 7/8/20.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCTipsUtils+ErrorCode.h"

@implementation MCTipsUtils (ErrorCode)

+ (void)showErrorTipsWithCode:(MCCode)errorCode completionHandler:(void (^ __nullable)(void))completionHandler {
    switch (errorCode) {
        case MCCodeVertificationCodeError:
            [MCTipsUtils showErrorWithTips:MCLocal(@"tips_verifiycode_error")];
            break;
        case MCCodeAccountFormatError:
            [MCTipsUtils showErrorWithTips:MCLocal(@"tips_account_format_error")];
            break;
        case MCCodeLoginPasswordError:
            [MCTipsUtils showErrorWithTips:MCLocal(@"tips_passwd_error")];
            break;
        case MCCodeAccountExistent:
            [MCTipsUtils showErrorWithTips:MCLocal(@"user_existed")];
            break;
        case MCCodeAccountInexistent:
            [MCTipsUtils showErrorWithTips:MCLocal(@"tips_account_not_exist")];
            break;
        case MCCodeRemoteLogin:
            [MCTipsUtils showErrorWithTips:MCLocal(@"remote_login")];
            break;
            
        default:
            break;
    }
    if (completionHandler) {
        completionHandler();
    }
}

@end
