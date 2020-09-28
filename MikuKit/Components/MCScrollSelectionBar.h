//
//  MCScrollSelectionBar.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/9/17.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCScrollSelectionBar : UIView

@property (nonatomic, copy) void(^selectItemBlock)(NSUInteger selectIndex, NSString *selectTitle);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles;

// MARK: 禁止外部调用
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE;          // 没有遵循协议可以不写
- (id)mutableCopy NS_UNAVAILABLE;   // 没有遵循协议可以不写

@end

NS_ASSUME_NONNULL_END
