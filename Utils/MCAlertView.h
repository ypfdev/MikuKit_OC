//
//  MCAlertView.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "LGAlertView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GPAlertType){
    GPAlertTypeVersion          = 0,   /**< 版本更新*/
    GPAlertTypeLocation         = 1,   /**< 门店位置*/
    GPAlertTypeSePhone          = 2,   /**< 服务电话*/
    GPAlertTypeSetAddress       = 3,   /**< 设置地址*/
    GPAlertTypeCreateOrderExit  = 4,   /**< 退出填写订单*/
    GPAlertTypeDeleteOrder      = 5,   /**< 删除订单*/
    GPAlertTypeCancelOrder      = 6,   /**< 取消订单*/
};


@protocol MCAlertDelegate <NSObject>

@optional
- (void)alertViewCancelled:(__kindof UIView *)alertView;
- (void)alertViewDestructed:(__kindof UIView *)alertView;
- (void)alertView:(__kindof UIView *)alertView clickedButtonAtIndex:(NSUInteger)index title:(NSString *)title;

@end


@interface MCAlertView : UIView

@property (nonatomic, copy) NSString *title;            // 标题文字
@property (nonatomic, copy) NSString *message;          // 消息文字
@property (nonatomic, copy) NSString *cancelTitle;      // 取消按钮文字
@property (nonatomic, copy) NSString *destructiveTitle; // 确定按钮文字
@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

/**
 类方法：快输创建确认弹窗
 
 @param title 标题文字
 @param message 消息文字
 @param cancel 取消按钮的文字
 @param destructive 确认按钮的文字
 @param delegate 代理
 @return 弹窗对象
 */
+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive delegate:(id<MCAlertDelegate>)delegate;


/**
 类方法：快输创建确认弹窗
 
 @param title 标题文字
 @param message 消息文字
 @param cancel 取消按钮的文字
 @param destructive 确认按钮的文字
 @param delegate 代理
 @return 弹窗对象
 */


/**
 快输创建带消失回调的确认弹窗

 @param title 标题文字
 @param message 消息文字
 @param cancel 取消按钮的文字
 @param destructive 确认按钮的文字
 @param delegate 代理
 @param dissmissAction 弹窗消失后的回调
 @return 弹窗对象
 */
+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive delegate:(id<MCAlertDelegate>)delegate dismissAction:(BOOL)dissmissAction;

/**
 弹窗消失的方法
 */
- (void)dismissAction;

// 弹窗消失的方法
+ (void)dismiss;





#pragma mark - 带回调

/**
 快速创建带取消/确认回调的弹窗
 
 @param title 弹窗标题
 @param message 弹窗信息
 @param imgStr 顶部图片
 @param cancelBtnTitle 取消按钮标题文字
 @param destructiveBtnTitle 确认按钮标题文字
 @param cancelBlock 取消回调
 @param destructiveBlock 确认回调
 @return 弹窗对象
 */
+ (instancetype)showAlertWithTitle:(nullable NSString *)title
                           message:(nullable NSString *)message
                            imgStr:(nullable NSString *)imgStr
                    cancelBtnTitle:(nullable NSString *)cancelBtnTitle
               destructiveBtnTitle:(NSString *)destructiveBtnTitle
                       cancelBlock:(void (^ __nullable)(void))cancelBlock
                  destructiveBlock:(void (^ __nullable)(void))destructiveBlock;

@end

NS_ASSUME_NONNULL_END
