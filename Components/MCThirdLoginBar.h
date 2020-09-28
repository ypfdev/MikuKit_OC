//
//  MCThirdLoginBar.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/6/9.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCThirdLoginBar : UIView

@property (nonatomic, copy) void(^loginByAppleBlock)(void);
@property (nonatomic, copy) void(^loginByGooleBlock)(void);
@property (nonatomic, copy) void(^loginByFacebookBlock)(void);

@end

NS_ASSUME_NONNULL_END
