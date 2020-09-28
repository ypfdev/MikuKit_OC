//
//  MKStandardClickAreaButton.m
//  PureGarden
//
//  Created by 原鹏飞 on 2017/11/17.
//  Copyright © 2017年 HappyCastle. All rights reserved.
//

#import "MKStandardClickAreaButton.h"

@implementation MKStandardClickAreaButton

/// 重写判断触点的方法，以响应标准热区外的点击
/// @param point 触点
/// @param event 事件
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect bounds = self.bounds;
    // 若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat Δw = MAX(44.0 - bounds.size.width, 0);
    CGFloat Δh = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, - Δw * 0.5, - Δh * 0.5);
    return CGRectContainsPoint(bounds, point);
}

@end
