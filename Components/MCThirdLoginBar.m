//
//  MCThirdLoginBar.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/6/9.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCThirdLoginBar.h"

@interface MCThirdLoginBar ()

@property (nonatomic, weak) UIStackView *loginBar;

@end

@implementation MCThirdLoginBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    UIButton *appleItem = [[UIButton alloc] init];
    appleItem.tag = 1010;
    appleItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [appleItem setImage:[UIImage imageNamed:@"icon_login_apple"] forState:UIControlStateNormal];
    [appleItem addTarget:self action:@selector(clickBarItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *googleItem = [[UIButton alloc] init];
    googleItem.tag = 1011;
    googleItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [googleItem setImage:[UIImage imageNamed:@"icon_login_google"] forState:UIControlStateNormal];
    [googleItem addTarget:self action:@selector(clickBarItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *facebookItem = [[UIButton alloc] init];
    facebookItem.tag = 1012;
    facebookItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [facebookItem setImage:[UIImage imageNamed:@"icon_login_facebook"] forState:UIControlStateNormal];
    [facebookItem addTarget:self action:@selector(clickBarItem:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *itemArr = [NSArray new];
    if (@available(iOS 13.0,*)) {
        itemArr = @[appleItem, googleItem, facebookItem];
    } else {
        itemArr = @[googleItem, facebookItem];
    }
    
    // 添加栈
    // 使用UIStackView自动布局，可以保证fakeTabBar与系统tabBar的图标位置&大小一致
    UIStackView *stackV = [[UIStackView alloc] initWithArrangedSubviews:itemArr];
    stackV.distribution = UIStackViewDistributionFillEqually;
    self.loginBar = stackV;
    [self addSubview:self.loginBar];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.loginBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

- (void)clickBarItem:(UIButton *)sender {
    if (sender.tag == 1010) {
        if (self.loginByAppleBlock) {
            [MCTipsUtils showTips:@"Sign in with Apple"];
            self.loginByAppleBlock();
        }
    } else if (sender.tag == 1011) {
        if (self.loginByGooleBlock) {
            [MCTipsUtils showTips:@"Sign in with google"];
            self.loginByGooleBlock();
        }
    } else if (sender.tag == 1012) {
        if (self.loginByFacebookBlock) {
            [MCTipsUtils showTips:@"Sign in with facebook"];
            self.loginByFacebookBlock();
        }
    }
}

@end
