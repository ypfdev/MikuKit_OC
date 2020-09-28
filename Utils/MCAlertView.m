//
//  MCAlertView.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/10.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCAlertView.h"
#import "UILabel+MKExtension.h"


@interface GPAlertHelper :NSObject

@property (nonatomic, weak) MCAlertView *alertView;   // 正在显示的弹窗

@end

@implementation GPAlertHelper

+ (instancetype)defaultHelper{
    static GPAlertHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [GPAlertHelper new];
    });
    return helper;
}

@end


@interface MCAlertView ()

@property (nonatomic, weak) id<MCAlertDelegate> delegate;
@property (nonatomic, weak) UIView *mask;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *messageLabel;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIButton *destructiveButton;
@property (nonatomic, assign) BOOL dismiss;
@property (nonatomic, strong) UIImageView *topImage;
@property (nonatomic, copy) void(^cancelBlock)(void);
@property (nonatomic, copy) void(^destructiveBlock)(void);

@end


@implementation MCAlertView

#pragma mark - 初始化

+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive delegate:(id<MCAlertDelegate>)delegate {
    if ([GPAlertHelper defaultHelper].alertView != nil) {
        return nil;
    }
    
    MCAlertView *alert = [[MCAlertView alloc] initWithTitle:title
                                                    message:message ? message : @""
                                          cancelButtonTitle:cancel ? cancel : nil
                                     destructiveButtonTitle:destructive];
    alert.delegate = delegate;
    alert.dismiss = YES;
    [GPAlertHelper defaultHelper].alertView = alert;
    [alert show];
    
    return alert;
}

+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive delegate:(id)delegate dismissAction:(BOOL)dissmissAction {
    if ([GPAlertHelper defaultHelper].alertView != nil) {
        return nil;
    }
    
    MCAlertView *alert = [[MCAlertView alloc] initWithTitle:title
                                                    message:message ? message : @""
                                          cancelButtonTitle:cancel ? cancel : nil
                                     destructiveButtonTitle:destructive];
    alert.delegate = delegate;
    alert.dismiss = dissmissAction;
    [GPAlertHelper defaultHelper].alertView = alert;
    [alert show];
    
    return alert;
}


- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle {
    self = [super init];
    if (self) {
        self.backgroundColor =  COLOR_AP_BG_LIGHT;
        self.layer.cornerRadius = 5;
        self.message = message;
        UILabel *titleLabel;
        if ([title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 0) {
            titleLabel = [UILabel labelWithText:title textColor:[UIColor whiteColor] fontSize:16];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.numberOfLines = 0;
        }
        UILabel *messageLabel;
        if (titleLabel) {
            messageLabel = [UILabel labelWithText:message textColor:[UIColor mk_colorWithHex:0xFFFFFF alpha:0.5] fontSize:14];
        } else {
            messageLabel = [UILabel labelWithText:message textColor:[UIColor mk_colorWithHex:0xFFFFFF] fontSize:16];
        }
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        
        UIButton *cancelButton = [UIButton new];
        cancelButton.titleLabel.font = FONT_PingFangSC_Regular(17);
        [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:COLOR_AP_TEXT forState:UIControlStateNormal];
        [cancelButton setTitleColor:COLOR_AP_THEME forState:UIControlStateHighlighted];
//        [cancelButton setBackgroundImage:ASImageWithHexColor(0xFFFFFF, 1) forState:UIControlStateNormal];
//        [cancelButton setBackgroundImage:ASImageWithHexColor(0xFF1832, 1) forState:UIControlStateHighlighted];
//        cancelButton.layer.cornerRadius = 2;
//        cancelButton.layer.masksToBounds = YES;
//        cancelButton.layer.borderColor = redColor.CGColor;
//        cancelButton.layer.borderWidth = 1;
        [cancelButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *destructiveButton = [UIButton new];
        destructiveButton.titleLabel.font = FONT_PingFangSC_Regular(17);
        [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
        [destructiveButton setTitleColor:COLOR_AP_THEME forState:UIControlStateNormal];
        [destructiveButton setTitleColor:COLOR_AP_THEME forState:UIControlStateHighlighted];
//        [destructiveButton setBackgroundImage:ASImageWithHexColor(0xFF1832, 1) forState:UIControlStateNormal];
//        [destructiveButton setBackgroundImage:ASImageWithHexColor(0xFFFFFF, 1) forState:UIControlStateHighlighted];
//        destructiveButton.layer.borderColor = COLOR_AP_THEME.CGColor;
//        destructiveButton.layer.borderWidth = 1;
//        destructiveButton.layer.cornerRadius = 2;
//        destructiveButton.layer.masksToBounds = YES;
        [destructiveButton addTarget:self action:@selector(destructive:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:messageLabel];
        if (cancelButtonTitle) {
            [self addSubview:cancelButton];
        }
        [self addSubview:destructiveButton];
        CGFloat margin = 16;
        if (titleLabel) {
            [self addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(20);
                make.height.equalTo(@16);
                make.centerX.equalTo(self);
                make.left.equalTo(self).offset(margin);
                make.right.equalTo(self).offset(-margin);
            }];
            
            [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleLabel.mas_bottom).offset(30);
                make.left.right.equalTo(titleLabel);
                make.bottom.equalTo(destructiveButton.mas_top).offset(-30);
            }];
        } else {
            [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(30);
                make.bottom.equalTo(destructiveButton.mas_top).offset(-30);
                make.left.equalTo(self).offset(margin);
                make.right.equalTo(self).offset(-margin);
            }];
        }
        
        if (cancelButtonTitle) {
            [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).multipliedBy(164/300.0);
                make.width.equalTo(self).multipliedBy(100/300.0);
                make.height.equalTo(@30);
                make.bottom.mas_equalTo(-15);
            }];
        }
        
        [destructiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            if (cancelButtonTitle) {
                make.centerX.equalTo(self).multipliedBy(436/300.0);
                make.centerY.width.height.equalTo(cancelButton);
            } else {
                make.centerX.equalTo(self);
                make.bottom.mas_equalTo(-15);
                make.height.equalTo(@30);
                make.width.equalTo(self).multipliedBy(100/300.0);
            }
        }];
        
        self.titleLabel = titleLabel;
        self.messageLabel = messageLabel;
        self.cancelButton = cancelButton;
        self.destructiveButton = destructiveButton;
    }
    return self;
}

- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    UIView *maskView = [UIView new];
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.mask = maskView;
    [keyWindow addSubview:maskView];
    [maskView addSubview:self];
    
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.centerX.equalTo(maskView);
        make.height.mas_greaterThanOrEqualTo(kAdaptedWidth(180));
        make.width.equalTo(maskView).multipliedBy(270/375.0);
    }];
    
    [keyWindow layoutIfNeeded];
    
    maskView.alpha = 0;
    self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    [UIView animateWithDuration:.25 animations:^{
        maskView.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismiss:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:title:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:0 title:sender.titleLabel.text];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewCancelled:)]) {
        [self.delegate alertViewCancelled:self];
    }
    [self dismissAction];
}

- (void)dismissAction {
    [UIView animateWithDuration:.25 animations:^{
        self.mask.alpha = 0;
    } completion:^(BOOL finished) {
        [self.mask removeFromSuperview];
    }];
}


// 弹窗消失的方法
+ (void)dismiss {
    [UIView animateWithDuration:.25 animations:^{
        [GPAlertHelper defaultHelper].alertView.mask.alpha = 0;
    } completion:^(BOOL finished) {
        [[GPAlertHelper defaultHelper].alertView.mask removeFromSuperview];
    }];
}


- (void)destructive:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:title:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:1 title:sender.titleLabel.text];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewDestructed:)]) {
        [self.delegate alertViewDestructed:self];
    }
    if (_dismiss) {
        [self dismissAction];
    }
}

#pragma mark - Setter/Getter

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.superview layoutIfNeeded];
}

- (NSString *)title{
    return self.titleLabel.text;
}

- (void)setMessage:(NSString *)message {
    self.messageLabel.text = message;
    [self.superview layoutIfNeeded];
}

- (NSString *)message{
    return self.messageLabel.text;
}

- (void)setCancelTitle:(NSString *)cancelTitle {
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
}

- (NSString *)cancelTitle{
    return self.cancelButton.titleLabel.text;
}

- (void)setDestructiveTitle:(NSString *)destructiveTitle {
    [self.destructiveButton setTitle:destructiveTitle forState:UIControlStateNormal];
}

- (NSString *)destructiveTitle{
    return self.destructiveButton.titleLabel.text;
}

- (void)setParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle {
    _paragraphStyle = paragraphStyle;
    if (paragraphStyle) {
        self.messageLabel.attributedText = [[NSAttributedString alloc] initWithString:self.messageLabel.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    }
}


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
                  destructiveBlock:(void (^ __nullable)(void))destructiveBlock {
    if ([GPAlertHelper defaultHelper].alertView != nil) {
        return nil;
    }
    
    MCAlertView *alert = [[MCAlertView alloc] initWithTitle:title message:message imgStr:imgStr cancelBtnTitle:cancelBtnTitle destructiveBtnTitle:destructiveBtnTitle cancelBlock:cancelBlock destructiveBlock:destructiveBlock];
    
    alert.dismiss = YES;
    [GPAlertHelper defaultHelper].alertView = alert;
    [alert show];
    
    return alert;
}



- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message imgStr:(NSString *)imgStr
               cancelBtnTitle:(NSString *)cancelBtnTitle
          destructiveBtnTitle:(NSString *)destructiveBtnTitle
                  cancelBlock:(void (^ __nullable)(void))cancelBlock
             destructiveBlock:(void (^ __nullable)(void))destructiveBlock {
    self = [super init];
    if (self) {
        self.backgroundColor =  [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.message = message;
        self.cancelBlock = cancelBlock;
        self.destructiveBlock = destructiveBlock;
        if (imgStr!=nil) {
            self.topImage=[UIImageView new];
            self.topImage.image=[UIImage imageNamed:imgStr];
            [self addSubview:self.topImage];
            [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.centerX.equalTo(self);
                make.height.width.equalTo(@80);
                make.centerY.equalTo(self.mas_top).offset(10);
            }];
        }
        
        
        UILabel *titleLabel;
        if ([title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 0) {
            titleLabel = [UILabel labelWithText:title textColor:[UIColor blackColor] fontSize:16];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.numberOfLines = 0;
        }
        UILabel *messageLabel;
        if (titleLabel) {
            messageLabel = [UILabel labelWithText:message textColor:[UIColor blackColor] fontSize:14];
        } else {
            messageLabel = [UILabel labelWithText:message textColor:[UIColor blackColor] fontSize:16];
        }
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        
        UIButton *cancelButton = [UIButton new];
        cancelButton.titleLabel.font = FONT_PingFangSC_Regular(17);
        [cancelButton setTitle:cancelBtnTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setBackgroundColor:[UIColor grayColor]];
        
        UIButton *destructiveButton = [UIButton new];
        destructiveButton.titleLabel.font = FONT_PingFangSC_Regular(17);
        [destructiveButton setTitle:destructiveBtnTitle forState:UIControlStateNormal];
        [destructiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [destructiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [destructiveButton addTarget:self action:@selector(clickDestructiveBtn:) forControlEvents:UIControlEventTouchUpInside];
        [destructiveButton setBackgroundColor:[UIColor mk_colorWithHex:0x318FFF]];
        [self addSubview:messageLabel];
        if (cancelBtnTitle) {
            [self addSubview:cancelButton];
        }
        [self addSubview:destructiveButton];
        CGFloat margin = 16;
        if (titleLabel) {
            [self addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(20);
                make.height.equalTo(@16);
                make.centerX.equalTo(self);
                make.left.equalTo(self).offset(margin);
                make.right.equalTo(self).offset(-margin);
            }];
            
            [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleLabel.mas_bottom).offset(30);
                make.left.right.equalTo(titleLabel);
                make.bottom.equalTo(destructiveButton.mas_top).offset(-30);
            }];
        } else {
            [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(30);
                make.bottom.equalTo(destructiveButton.mas_top).offset(-30);
                make.left.equalTo(self).offset(margin);
                make.right.equalTo(self).offset(-margin);
            }];
        }
        
        if (cancelBtnTitle) {
            [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).multipliedBy(164/300.0);
                make.width.equalTo(self).multipliedBy(100/300.0);
                make.height.equalTo(@30);
                make.bottom.mas_equalTo(-15);
            }];
        }
        
        [destructiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            if (cancelBtnTitle) {
                make.centerX.equalTo(self).multipliedBy(436/300.0);
                make.centerY.width.height.equalTo(cancelButton);
            } else {
                make.centerX.equalTo(self);
                make.bottom.mas_equalTo(-15);
                make.height.equalTo(@30);
                make.width.equalTo(self).multipliedBy(100/300.0);
            }
        }];
       
        
        self.titleLabel = titleLabel;
        self.messageLabel = messageLabel;
        self.cancelButton = cancelButton;
        self.destructiveButton = destructiveButton;
        self.cancelButton.layer.masksToBounds=YES;
        self.cancelButton.layer.cornerRadius=15;
        self.destructiveButton.layer.masksToBounds=YES;
        self.destructiveButton.layer.cornerRadius=15;
      
        
    }
    return self;
}


- (void)clickCancelBtn:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissAction];
}


- (void)clickDestructiveBtn:(UIButton *)sender {
    if (self.destructiveBlock) {
        self.destructiveBlock();
    }
    if (self.dismiss) {
        [self dismissAction];
    }
}

@end
