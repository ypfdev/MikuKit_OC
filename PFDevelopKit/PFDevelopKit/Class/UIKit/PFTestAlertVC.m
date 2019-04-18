//
//  PFTestAlertVC.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/16.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "PFTestAlertVC.h"

#import "UIAlertController+PPP.h"

@interface PFTestAlertVC ()

@property (nonatomic, strong) UIButton *testBtn;

@end

@implementation PFTestAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    _testBtn = [UIButton pf_buttonWithTitle:@"Alert" andTitleColor:UIColor.redColor andBorderWidth:0.5f andBorderColor:UIColor.redColor.CGColor];
    [self.view addSubview:_testBtn];
    [_testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
    }];
    [_testBtn addTarget:self action:@selector(clickTestBtn:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)clickTestBtn:(UIButton *)sender {
    NSLog(@"点击测试");
    
//    UIAlertController *alertC = [UIAlertController pf_alertControllerWithTitle:@"标题" message:@"消息"];
//    [self presentViewController:alertC animated:YES completion:nil];
    
    MBProgressHUD *mb = [[MBProgressHUD alloc] init];
    mb.label.text = @"呜哩哇啦";
    mb.label.textColor = UIColor.redColor;
    [self.view addSubview:mb];
    [mb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kAdaptedWidth(50));
        make.bottom.equalTo(self.view).offset(kAdaptedWidth(-100));
        make.height.mas_equalTo(kAdaptedWidth(50));
        make.width.mas_equalTo(kAdaptedWidth(100));
    }];
    
    [mb showAnimated:YES];
    [mb hideAnimated:YES afterDelay:2];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
