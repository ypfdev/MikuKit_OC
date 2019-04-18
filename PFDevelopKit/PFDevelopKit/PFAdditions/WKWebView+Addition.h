//
//  WKWebView+Addition.h
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/13.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (Addition)

- (NSString *)pf_htmlForJPGImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
