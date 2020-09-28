//
//  MCSectorProgressView.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/11/4.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCSectorProgressView : UIView

@property(assign,nonatomic)CGFloat progress;
@property (nonatomic, strong) UILabel *progressLabel;

@end

NS_ASSUME_NONNULL_END
