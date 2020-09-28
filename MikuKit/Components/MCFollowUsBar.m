//
//  MCFollowUsBar.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/3/19.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCFollowUsBar.h"

@interface MCFollowUsBar ()

@property (nonatomic, weak) UILabel *followBarTitle;
@property (nonatomic, weak) UIView *followBarSeperator;
@property (nonatomic, weak) UIStackView *followBar;

@end

@implementation MCFollowUsBar

/// 重写默认初始化方法，创建子控件并添加到父视图
/// @param frame 控件框架
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    // 添加follow标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = MCLocal(@"follow_us");
    titleLabel.font = FONT_PingFangSC_Regular(12);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.followBarTitle = titleLabel;
    [self addSubview:self.followBarTitle];
    
    // 添加分隔线
    UIView *seperator = [[UIView alloc] init];
    self.followBarSeperator = seperator;
    [self insertSubview:self.followBarSeperator belowSubview:self.followBarTitle];
    
    // 添加按钮栈
    UIButton *instagramItem = [[UIButton alloc] init];
    instagramItem.tag = 1010;
    instagramItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [instagramItem setImage:[UIImage imageNamed:@"ic_follow_instagram"] forState:UIControlStateNormal];
    [instagramItem addTarget:self action:@selector(clickFollowItem:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *facebookItem = [[UIButton alloc] init];
    facebookItem.tag = 1012;
    facebookItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [facebookItem setImage:[UIImage imageNamed:@"ic_follow_facebook"] forState:UIControlStateNormal];
    [facebookItem addTarget:self action:@selector(clickFollowItem:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *twitterItem = [[UIButton alloc] init];
    twitterItem.tag = 1013;
    twitterItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [twitterItem setImage:[UIImage imageNamed:@"ic_follow_twitter"] forState:UIControlStateNormal];
    [twitterItem addTarget:self action:@selector(clickFollowItem:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *youtobeItem = [[UIButton alloc] init];
    youtobeItem.tag = 1014;
    youtobeItem.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [youtobeItem setImage:[UIImage imageNamed:@"ic_follow_youtobe"] forState:UIControlStateNormal];
    [youtobeItem addTarget:self action:@selector(clickFollowItem:) forControlEvents:UIControlEventTouchUpInside];
    
    // 使用UIStackView自动布局，可以保证fakeTabBar与系统tabBar的图标位置&大小一致
    NSArray<UIButton *> *itemArrM = [NSArray new];
#if App_Apeman || App_Crosstour
    itemArrM = @[instagramItem, facebookItem, twitterItem, youtobeItem];
    seperator.backgroundColor = [UIColor mk_colorWithHex:0x979797 alpha:0.2];
    titleLabel.textColor = [UIColor mk_colorWithHex:0xFFFFFF alpha:0.6];
    titleLabel.backgroundColor = COLOR_AP_BG_LIGHT;
#elif App_Victure
    itemArrM = @[facebookItem, youtobeItem];
    seperator.backgroundColor = [UIColor mk_colorWithHex:0xB6BABE];
    titleLabel.textColor = [UIColor mk_colorWithHex:0x6C7072];
    titleLabel.backgroundColor = [UIColor mk_colorWithHex:0xF4F5F8];
#endif
    UIStackView *stackV = [[UIStackView alloc] initWithArrangedSubviews:itemArrM];
    stackV.distribution = UIStackViewDistributionFillProportionally;
    self.followBar = stackV;
    [self addSubview:self.followBar];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    
    [self.followBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(size.height * 0.5);
    }];
    
    [self.followBarTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(size.height * 0.33);
//        make.width.mas_equalTo(size.width * 0.33);
    }];
    
    [self.followBarSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.followBarTitle);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(size.width * 0.85);
    }];
}

/// 点击社交主页栏
/// @param sender 目标控件
- (void)clickFollowItem:(UIButton *)sender {
    if (sender.tag == 1010) {
        [self handleFollowType:MCFollowTypeInstagram];
    } else if (sender.tag == 1012) {
        [self handleFollowType:MCFollowTypeFacebook];
    } else if (sender.tag == 1013) {
        [self handleFollowType:MCFollowTypeTwitter];
    } else if (sender.tag == 1014) {
        [self handleFollowType:MCFollowTypeYoutube];
    }
}

- (void)handleFollowType:(MCFollowType)followType {
    NSString *scheme = @"";
    NSString *appUrl = @"";
    NSString *webUrl = @"";
#if App_Apeman
    if (followType == MCFollowTypeInstagram) {
        scheme = @"instagram://";
        appUrl = @"instagram://user?username=Apeman_official";
        webUrl = @"https://www.instagram.com/apeman_official/";
    } else if (followType == MCFollowTypeFacebook) {
        scheme = @"fb://";
        appUrl = @"fb://profile/904383966337373";
        webUrl = @"https://www.facebook.com/apeman.life/";
    } else if (followType == MCFollowTypeTwitter) {
        scheme = @"twitter://";
        appUrl = @"twitter://user?id=986886663514112001";
        webUrl = @"https://twitter.com/Apeman_official";
    } else if (followType == MCFollowTypeYoutube) {
        scheme = @"youtube://";
        appUrl = @"youtube://www.youtube.com/user/UCHFBokbgYAHIifpmjnbRf7g";
        webUrl = @"https://www.youtube.com/channel/UCHFBokbgYAHIifpmjnbRf7g";
    }
#elif App_Crosstour
    if (followType == MCFollowTypeInstagram) {
        scheme = @"instagram://";
        appUrl = @"instagram://user?username=crosstour_official";
        webUrl = @"https://www.instagram.com/crosstour_official";
    } else if (followType == MCFollowTypeFacebook) {
        scheme = @"fb://";
        appUrl = @"fb://profile/267849564035007";
        webUrl = @"https://www.facebook.com/crosstourworld";
    } else if (followType == MCFollowTypeTwitter) {
        scheme = @"twitter://";
        appUrl = @"twitter://user?id=821353955359789057";
        webUrl = @"https://twitter.com/CrosstourCam";
    } else if (followType == MCFollowTypeYoutube) {
        scheme = @"youtube://";
        appUrl = @"youtube://www.youtube.com/user/UCmZip95dtcB1C9QL_58rTcA";
        webUrl = @"https://www.youtube.com/channel/UCmZip95dtcB1C9QL_58rTcA";
    }
#elif App_Victure
    if (followType == MCFollowTypeFacebook) {
        scheme = @"fb://";
        appUrl = @"fb://profile/1943933388965341";
        webUrl = @"https://www.facebook.com/Victure-1943933388965341/";
    } else if (followType == MCFollowTypeYoutube) {
        scheme = @"youtube://";
        appUrl = @"youtube://www.youtube.com/user/UCxX2Rh9MOahQlPEddrwG5xQ";
        webUrl = @"https://www.youtube.com/channel/UCxX2Rh9MOahQlPEddrwG5xQ";
    }
#endif
    [self openAppHomePageWithScheme:[NSURL URLWithString:scheme]
                             appUrl:[NSURL URLWithString:appUrl]
                             webUrl:[NSURL URLWithString:webUrl]];
}

- (void)openAppHomePageWithScheme:(NSURL *)scheme
                           appUrl:(NSURL *)appUrl
                           webUrl:(NSURL *)webUrl {
    // 如果已安装渠道App，直接打开App并跳转到指定用户主页；否则使用Safari打开页面
    BOOL appEnable = [[UIApplication sharedApplication] canOpenURL:scheme];
    if (@available(iOS 10.0,*)) {
        [[UIApplication sharedApplication] openURL:appEnable ? appUrl : webUrl options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:appEnable ? appUrl : webUrl];
    }
}

/// 跳转到AppStore中指定App主页
/// @param appID AppID
- (void)skipToAppStoreWithAppID:(NSString *)appID {
    /* 常用AppID
     instagram：id389801252
     facebook：id1142110895
     twitter：id333903271
     youtobe：id544007664
     */
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/%@", appID]];
    if (@available(iOS 10.0, *)){
        [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:^(BOOL success) {
            if (success) {
                
            } else {
                
            }
        }];
    } else {
        BOOL success = [[UIApplication sharedApplication] openURL:url];
        if (success) {
            
        } else {
            
        }
    }
}

/// App跳转到Safari并打开指定网页
/// @param url 网址
- (void)skipToSafariWithURL:(NSURL *)url {
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0,*)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
