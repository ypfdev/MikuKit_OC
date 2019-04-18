//
//  PFWKWebView.h
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/14.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFWKWebView : UIViewController

@property (nonatomic, copy  ) NSString *sourceStr;

- (void)loadData:(NSString *)sourceStr;

@end

NS_ASSUME_NONNULL_END
