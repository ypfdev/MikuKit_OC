//
//  MCUMengRecordTool.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/11/4.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMMobClick/MobClick.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCUMengRecordTool : NSObject

/**
 @ 页面统计 - 进入
 @param name  界面名称
 */
+ (void)umengEnterViewWithName:(NSString *)name;



/**
 @ 页面统计 - 退出
 @param name  界面名称
 */
+ (void)umengOutViewWithName:(NSString *)name;



/**
 @ 计数事件统计
 @param eventId   事件Id
 */
+ (void)umengEventCountWithId:(NSString *)eventId;



/**
 @ 计算事件统计
 @param eventId     事件Id
 @param attributes  统计内容
 @param number      统计的数
 */
+ (void)umengEventCalculatWithId:(NSString *)eventId
                      attributes:(NSDictionary *)attributes
                          number:(id)number;



/**
 ScrollView 已滚动/浏览的百分比

 @param eventId     事件Id
 @param attributes  内容[可不传、为nil]
 @param scrollview  滚动视图
 @param isVertical  竖直方向YES、 水平方向NO
 */
+ (void)umengEventScrollViewWithId:(NSString *)eventId
                        attributes:(NSDictionary *)attributes
                        scrollview:(UIScrollView *)scrollview
                        isVertical:(BOOL)isVertical;

@end

NS_ASSUME_NONNULL_END
