//
//  WKWebView+Addition.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/13.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "WKWebView+Addition.h"

@implementation WKWebView (Addition)


- (NSString *)pf_htmlForJPGImage:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image,1.f);
    NSString *imageSource = [NSString stringWithFormat:@"data:image/jpg;base64,%@", [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    return [NSString stringWithFormat:@"<div align=center><img src='%@' /></div>", imageSource];
}

@end
