//
//  MCTipsUtils.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCTipsUtils.h"
#import <MBProgressHUD.h>
#import "MCLoadingView.h"
#import <SDWebImage/UIImage+GIF.h>
#import <FLAnimatedImage.h>

@interface MCTipsUtils ()

@property (nonatomic, assign) MCTipsOrientation orientation;

@end

@implementation MCTipsUtils
#pragma mark - 通用提示
/**
 常用提示语
 
 @param type 通用提示语类型
 */
+ (void)showNormalTips:(NormalTips)type{
    if (type < 100) {
        [self showHUDWithMessage:[self messageWithType:type]];
    }else{
        [self showTips:[self messageWithType:type]];
    }
}

+ (NSString *)messageWithType:(NormalTips)type{
    NSString *tips;
    switch (type) {
        case NormalTipsLoading:
            tips = @"正在加载";
            break;
        case NormalTipsSending:
            tips = @"正在发送";
            break;
        case NormalTipsConnecting:
            tips = @"正在连接";
            break;
        case NormalTipsLogining:
            tips = @"正在登录";
            break;
        case NormalTipsNetworkTimeout:
            tips = @"网络异常";
            break;
        case NormalTipsNetworkUnusual:
            tips = @"连接超时";
            break;
        case NormalTipsRequestFailed:
            tips = @"请求失败";
            break;
        case NormalTipsOperationSuccess:
            tips = @"操作成功";
            break;
        case NormalTipsDownloadFail:
            tips = @"下载失败";
            break;
        default:
            break;
    }
    return tips;
}

#pragma mark - 提示（带菊花）
/**
 白色背景遮挡内容的菊花（view上，需手动隐藏）
 */
+ (void)showMaskHUDWithMessage:(NSString *)message inView:(UIView *)view {
    [self hideHUD];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message inView:view icon:nil yOffset:0];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.backgroundColor = [UIColor whiteColor];
    });
}

/**
 菊花（Window上，需手动隐藏）
 */
+ (void)showHUD{
//    [self showHUDWithMessage:nil];
    [self showHUDWithMessage:@""];
}

/**
 带信息菊花（Window上，需手动隐藏）
 
 @param message 提示信息
 */
+ (void)showHUDWithMessage:(NSString *)message{
    [self showHUDWithMessage:message inView:nil];
}

/**
 带信息菊花（View上，需手动隐藏）
 
 @param message 提示信息
 @param view 显示提示的View
 */
+ (void)showHUDWithMessage:(NSString *)message inView:(UIView *)view{
    [self showHUDWithMessage:message inView:view delay:0];
}

/**
 带信息菊花（View上，自动隐藏）
 
 @param message 提示信息
 @param view 显示提示的View
 @param time 自动隐藏延迟时间
 */
+ (void)showHUDWithMessage:(NSString *)message inView:(UIView *)view delay:(NSTimeInterval)time{
    [self hideHUD];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message inView:view icon:nil yOffset:0];
        // 延时
        if (time > 0) {
            [hud hideAnimated:YES afterDelay:time];
            if (view) {
                hud.completionBlock = ^{
                    [[GHUDHelp share].hudViews removeObject:view];
                };
            }
        }
    });
}

#pragma mark - 提示（不带菊花）

/**
 提示（Window上，1.5s后自动隐藏）
 
 @param message 提示信息
 */
+ (void)showTips:(NSString *)message{
    [MCTipsUtils showTips:message inView:nil];
}

+ (void)showTips:(NSString *)message orientation:(MCTipsOrientation)orientation {
    
    
}

+ (void)showTipsWithCode:(MCCode)code successMsg:(nullable NSString *)successMsg originalMsg:(nullable NSString *)originalMsg {
    switch (code) {
        case MCCodeSuccess:
            if (successMsg != nil) {
                [MCTipsUtils showTips:successMsg];
            } else {
                [MCTipsUtils showTips:@"Success!"];
            }
            break;
        case MCCodeVertificationCodeError:
            [MCTipsUtils showTips:@"Vertification code error!"];
            break;
        case MCCodeAccountFormatError:
            [MCTipsUtils showTips:@"Account format error!"];
            break;
        case MCCodeLoginPasswordError:
            [MCTipsUtils showTips:@"Login password error!"];
            break;
        case MCCodeAccountExistent:
            [MCTipsUtils showTips:@"Account existent!"];
            break;
        case MCCodeAccountInexistent:
            [MCTipsUtils showTips:@"Account inexistent!"];
            break;
        case MCCodeTooMuchUnprocessedFeedback:
            [MCTipsUtils showTips:@"Too much unprocessed feedback!"];
            break;
            
        default:
            //
            if (originalMsg) {
                [MCTipsUtils showTips:originalMsg];
            }
            break;
    }
}

/**
 提示（Window上，显示在底部，1.5s后自动隐藏）
 
 @param message 提示信息
 */
+ (void)showBottomTips:(NSString *)message{
    [self showTips:message inView:nil delay:1.5 yOffset:MCBounds.screenH/2-80];
}

/**
 提示（Window上，显示在顶部，1.5s后自动隐藏）
 
 @param message 提示信息
 */
+ (void)showTopTips:(NSString *)text {
    UIWindow *KeyWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];

    UIView * tempView = [KeyWindow viewWithTag:677];
    if (tempView) {
        [tempView removeFromSuperview];
    }
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KeyWindow.frame.size.width - 60, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 30;
    CGFloat height = 110.f;
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, MCBounds.statusBarH, width, height)];
    backView.backgroundColor = COLOR_CT_TEXT;
    backView.layer.cornerRadius = 30.f;
    backView.clipsToBounds = YES;
    backView.tag = 677;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width - 30.f, rect.size.height)];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.userInteractionEnabled = YES;
    label.center = CGPointMake(backView.frame.size.width / 2, backView.frame.size.height / 2);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    
    [KeyWindow addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
        make.top.mas_equalTo(KeyWindow).with.offset(MCBounds.statusBarH);
        make.centerX.mas_equalTo(0);
    }];
    
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width - 30.f);
        make.height.mas_equalTo(rect.size.height);
        make.center.mas_equalTo(0);
    }];
    
    backView.alpha = 0.f;
    [UIView animateWithDuration:.2f animations:^{
        backView.alpha = 1.f;
    }];
    
    [UIView animateWithDuration:.5f delay:2.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        backView.alpha = 0.f;
    } completion:^(BOOL finished) {
        if (finished) {
            [backView removeFromSuperview];
        }
        
    }];
    
}

/**
 提示（View上，1.5s后自动隐藏）
 
 @param message 提示信息
 @param view 显示提示的View
 */
+ (void)showTips:(NSString *)message inView:(UIView *)view{
    [self showTips:message inView:view delay:1.5];
}

/**
 提示（View上，自动隐藏）
 
 @param message 提示信息
 @param view 显示提示的View
 @param time 自动隐藏时间
 */
+ (void)showTips:(NSString *)message inView:(UIView *)view delay:(NSTimeInterval)time{
    [self showTips:message inView:view delay:time yOffset:0];
}

/**
 提示（View上，自动隐藏）
 
 @param message 提示信息
 @param view 显示提示的View
 @param time 自动隐藏时间
 @param yOffset 距离中心点的Y轴的位置
 */
+ (void)showTips:(NSString *)message inView:(UIView *)view delay:(NSTimeInterval)time yOffset:(CGFloat)yOffset{
    [self hideHUD];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message inView:view icon:nil yOffset:yOffset];
        hud.mode = MBProgressHUDModeText;
        if (time>0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES afterDelay:time];
                if (view) {
                    hud.completionBlock = ^{
                        [[GHUDHelp share].hudViews removeObject:view];
                    };
                }
            });
        }
    });
}

#pragma mark - 成功，失败
/**
 成功提示（View上，自动隐藏）
 
 @param message 提示信息
 */
+ (void)showSuccessWithTips:(NSString *)message{
    [self hideHUD];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message inView:nil icon:@"wanc" yOffset:0];
        hud.mode = MBProgressHUDModeCustomView;
        [hud hideAnimated:YES afterDelay:1.5];;
    });
}

/**
 成功提示（View上，自动隐藏）
 
 @param message 提示信息
 @param time 自动隐藏时间
 */
+ (void)showSuccessWithTips:(NSString *)message delay:(NSTimeInterval)time{
    [self hideHUD];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message inView:nil icon:@"wanc" yOffset:0];
        hud.mode = MBProgressHUDModeCustomView;
        if (time>0) {
            [hud hideAnimated:YES afterDelay:time];
        }
    });
}

/**
 错误提示（View上，自动隐藏）
 
 @param message 提示信息
 */
+ (void)showErrorWithTips:(NSString *)message{
    [self hideHUD];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message inView:nil icon:nil yOffset:0];
        hud.mode = MBProgressHUDModeCustomView;
        [hud hideAnimated:YES afterDelay:1.5];;
    });
}

/**
 错误提示（View上，自动隐藏）
 
 @param message 提示信息
 @param time 自动隐藏时间
 */
+ (void)showErrorWithTips:(NSString *)message delay:(NSTimeInterval)time{
    [self hideHUD];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message inView:nil icon:nil yOffset:0];
        hud.mode = MBProgressHUDModeCustomView;
        if (time>0) {
            [hud hideAnimated:YES afterDelay:time];;
        }
    });
}

#pragma mark - 隐藏
/**
 隐藏
 */
+ (void)hideHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *winView = (UIView*)[UIApplication sharedApplication].delegate.window;
        [MBProgressHUD hideHUDForView:winView animated:YES];
        for (UIView *view in [GHUDHelp share].hudViews) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        [[GHUDHelp share].hudViews removeAllObjects];
    });
}

/**
 隐藏
 
 @param view 所在View
 */
+ (void)hideHUDWithView:(UIView *)view{
    if ([[UIApplication sharedApplication].delegate.window isEqual:view]) {
        [MBProgressHUD hideHUDForView:view animated:YES];
    }
    else {
        [MBProgressHUD hideHUDForView:view animated:YES];
        [[GHUDHelp share].hudViews removeObject:view];
    }
}

/**
 初始化Hud
 
 @param message 提示语
 @param view 显示提示的View
 @return Hud
 */
+ (MBProgressHUD *)createMBProgressHUDviewWithMessage:(NSString*)message inView:(UIView *)view icon:(NSString *)icon yOffset:(CGFloat)yOffset {
    if (!view) {
        view = [UIApplication sharedApplication].delegate.window;
    } else {
        [[GHUDHelp share].hudViews addObject:view];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message ? message : nil;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.numberOfLines = 0;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.color = COLOR_AP_BG_LIGHT;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
//    hud.dimBackground = NO;
//    hud.minSize = CGSizeMake(45, 45); // 最小大小
    
    // 自定义加载动画
    // 方式1
//    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
//    UIImageView *iv = [[UIImageView alloc] init];
//    NSData *data = [NSData dataWithContentsOfFile:gifPath];
//    UIImage *animatedImage = [UIImage sd_animatedGIFWithData:data];
//    iv.image = animatedImage;
//    hud.customView = iv;
    // 方式2
//    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"gif_loading_CT" ofType:@"gif"];
//    UIImageView *iv = [[UIImageView alloc] init];
//    iv.yy_imageURL = [NSURL fileURLWithPath:gifPath];
//    hud.customView = iv;
    // 方式3（使用自定义动画视图）
//    hud.customView = [[MCLoadingView alloc] init];
    
#if App_Crosstour
//    hud.bezelView.color = [UIColor whiteColor];
    // 生成FLAnimatedImage
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"gif_loading_CT" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:gifData];
    // 生成FLAnimatedImageView
    FLAnimatedImageView *aniIV = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    aniIV.animatedImage = animatedImage;
    // 设置为自定义视图
    hud.customView = aniIV;
    [aniIV mk_resetRoundCorner:UIRectCornerAllCorners radius:5];
#else
    hud.bezelView.color = COLOR_AP_BG_LIGHT;
    hud.customView = [[MCLoadingView alloc] init];
#endif
    
    // 如果传入了图片名，就使用自定义视图
    if (icon) {
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    }
    // 设置垂直偏移
    if (yOffset > 0) {
        hud.offset = CGPointMake(0, yOffset);
    }
    return hud;
}


//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentWindowVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows){
            if (tempWindow.windowLevel == UIWindowLevelNormal){
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }
    else{
        result = window.rootViewController;
    }
    return  result;
}
+ (UIViewController *)getCurrentUIVC{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]){
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]){
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]){
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


#pragma mark - 自定义帧动画，待验证

+(MBProgressHUD *)showLoading:(UIView *)view title:(NSString *)title {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view==nil?[[UIApplication sharedApplication].windows lastObject]:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(120, 120);//定义弹窗的大小
    
    UIImage *image = [[UIImage imageNamed:@"ic_framing_battery_charge1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    UIImageView* mainImageView= [[UIImageView alloc] initWithImage:image];
    mainImageView.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"ic_framing_battery_charge1"],
                                     [UIImage imageNamed:@"ic_framing_battery_charge2"],
                                     [UIImage imageNamed:@"ic_framing_battery_charge3"],
                                     [UIImage imageNamed:@"ic_framing_battery_charge4"],
                                     [UIImage imageNamed:@"ic_framing_battery_charge5"],nil];
    [mainImageView setAnimationDuration:1.0f];
    [mainImageView setAnimationRepeatCount:10];
    [mainImageView startAnimating];
    hud.customView = mainImageView;
    hud.animationType = MBProgressHUDAnimationFade;
    
    return hud;
}

@end


@implementation GHUDHelp

static GHUDHelp *hudHelp = nil;

+ (GHUDHelp *)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hudHelp = [[self alloc] init];
    });
    return hudHelp;
}

- (NSMutableArray *)hudViews{
    if (!_hudViews) {
        _hudViews = [NSMutableArray array];
    }
    return _hudViews;
}

@end
