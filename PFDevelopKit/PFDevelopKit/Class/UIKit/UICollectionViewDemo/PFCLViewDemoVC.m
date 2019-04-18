//
//  PFCLViewDemoVC.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/27.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "PFCLViewDemoVC.h"
#import "GPSearchFilterVC.h"

@interface PFCLViewDemoVC ()

@property (nonatomic, strong) UIButton *filterBtn;

@end

@implementation PFCLViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}


- (void)initSubviews {
    _filterBtn = [UIButton pf_buttonWithTitle:@"筛选器" andTitleColor:UIColor.redColor andBorderWidth:0.5f andBorderColor:[UIColor redColor].CGColor];
    [self.view addSubview:_filterBtn];
    [_filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(200);
    }];
    [_filterBtn addTarget:self action:@selector(clickFilterBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)clickFilterBtn:(UIButton *)sender {
    
    GPSearchFilterVC *filterVC = [[GPSearchFilterVC alloc] init];
    filterVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    filterVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self presentViewController:filterVC animated:YES completion:^{
        [filterVC showAnimation];
    }];
}

@end
