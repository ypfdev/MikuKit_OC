//
//  MCFollowUsBar.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/19.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 页面显示模式
typedef NS_ENUM(NSUInteger, MCFollowType) {
    MCFollowTypeInstagram   = 0,
    MCFollowTypeFacebook    = 1,
    MCFollowTypeTwitter     = 2,
    MCFollowTypeYoutube     = 3,
};

@interface MCFollowUsBar : UIView

@end

NS_ASSUME_NONNULL_END
