//
//  MCMaskView.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/30.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCMaskView.h"

@interface MCMaskView ()

@property (nonatomic, assign) CGSize contentSize;

@end

@implementation MCMaskView

#pragma mark - Initializer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _maskView = [[UIView alloc] initWithFrame:frame];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

+ (MCMaskView *)maskViewWithContentView:(UIView *)contentView
                            contentSize:(CGSize)contentSize
                      maskDismissEnable:(BOOL)maskDismissEnable {
    MCMaskView *maskView = [[MCMaskView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskView.contentSize = contentSize;
    if (maskDismissEnable) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [maskView.maskView addGestureRecognizer:tap];
    }
    [maskView addView:contentView size:contentSize];
    return maskView;
}

+ (MCMaskView *)maskViewWithContentView:(UIView *)contentView
                            contentSize:(CGSize)contentSize
                          bottomSpacing:(CGFloat)bSpacing
                      maskDismissEnable:(BOOL)maskDismissEnable {
    MCMaskView *maskView = [[MCMaskView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskView.contentSize = contentSize;
    if (maskDismissEnable) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [maskView.maskView addGestureRecognizer:tap];
    }
    [maskView addView:contentView size:contentSize bottomSpacing:bSpacing];
    return maskView;
}


#pragma mark - Public Function

- (void)show {
    UIView *window = [UIApplication sharedApplication].windows[0].rootViewController.view;
    [window endEditing:YES];
    [self showWithView:window];
}

- (void)dismiss {
    [self.window endEditing:YES];
    [UIView animateWithDuration:0.1 animations:^{
        self.maskView.alpha = 0;
//        self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Private Function

- (void)addView:(UIView *)view size:(CGSize)size bottomSpacing:(CGFloat)bSpacing {
    _contentView = view;
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-bSpacing);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(size.height);
        make.width.mas_equalTo(size.width);
    }];
}

- (void)addView:(UIView *)view size:(CGSize)size {
    _contentView = view;
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(size.height);
        make.width.mas_equalTo(size.width);
    }];
}

- (void)showWithView:(UIView *)view {
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [view layoutIfNeeded];
    
    self.maskView.alpha = 0;
//    self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
    [UIView animateWithDuration:0.1 animations:^{
        self.maskView.alpha = 1;
//        self.contentView.transform = CGAffineTransformIdentity;
    } completion:self.showCompletion];
}

@end
