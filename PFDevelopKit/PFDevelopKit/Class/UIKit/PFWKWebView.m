//
//  PFWKWebView.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/14.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "PFWKWebView.h"
#import <WebKit/WebKit.h>

@interface PFWKWebView ()

@property (nonatomic, copy  ) NSString *htmlStr;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation PFWKWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initSubviews];
    [self loadData:self.sourceStr];
}


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.toolbarHidden = YES;
}


- (void)initData {
    if (self.sourceStr == nil) {
        self.sourceStr = @"<p>\r\n\t<img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i4\/170348015\/TB2ttQLo9tkpuFjy0FhXXXQzFXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i3\/170348015\/TB2_CEVoYFlpuFjy0FgXXbRBVXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i1\/170348015\/TB23UUOo80kpuFjy1zdXXXuUVXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i3\/170348015\/TB26LEAo4XlpuFjSsphXXbJOXXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i4\/170348015\/TB2CSNqpgJlpuFjSspjXXcT.pXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i2\/170348015\/TB2cqdUpmFjpuFjSszhXXaBuVXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i4\/170348015\/TB2E4MJoYtlpuFjSspfXXXLUpXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i3\/170348015\/TB2KpI.o90jpuFjy0FlXXc0bpXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i2\/170348015\/TB2CqMKo80kpuFjSsziXXa.oVXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i4\/170348015\/TB2AYour4lmpuFjSZPfXXc9iXXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i2\/170348015\/TB26LchrYxmpuFjSZJiXXXauVXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i1\/170348015\/TB2xe6Ar9VmpuFjSZFFXXcZApXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i1\/170348015\/TB2Is_Wr5RnpuFjSZFCXXX2DXXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i4\/170348015\/TB2XiHFr.hnpuFjSZFpXXcpuXXa-170348015.jpg\" \/><img align=\"absmiddle\" src=\"https:\/\/img.alicdn.com\/imgextra\/i1\/170348015\/TB25Rq1a1nAQeBjSZFkXXaC5FXa_!!170348015.jpg\" \/> \r\n<\/p>";
    }
}


- (void)initSubviews {
    self.view.backgroundColor = UIColor.redColor;
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.webView.backgroundColor = UIColor.orangeColor;
}


- (void)setSourceStr:(NSString *)sourceStr {
    _sourceStr = sourceStr;
    
    [self loadData:sourceStr];
}


- (void)loadData:(NSString *)sourceStr {
    if (sourceStr == nil) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"没有数据" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:^{
            [NSThread sleepForTimeInterval:1];
            [alertC dismissViewControllerAnimated:YES completion:nil];
        }];
        return;
    }
    
    self.htmlStr = [NSString stringWithFormat:@"<meta name=\"viewport\"content=\"width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no\"/><body><style>#content img{width:100%%}</style><div id=\"content\">%@</div></body>", sourceStr];
    [_webView loadHTMLString:self.htmlStr baseURL:nil];
}

@end
