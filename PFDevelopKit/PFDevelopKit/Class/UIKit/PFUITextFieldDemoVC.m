//
//  PFUITextFieldDemoVC.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/26.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "PFUITextFieldDemoVC.h"

@interface PFUITextFieldDemoVC () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *testTF;

@end

@implementation PFUITextFieldDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}


- (void)initSubviews {
    _testTF = [[UITextField alloc] init];
    [self.view addSubview:self.testTF];
    [self.testTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(200);
    }];
    self.testTF.delegate = self;
    self.testTF.keyboardType = UIKeyboardTypeNumberPad;
    self.testTF.textAlignment = NSTextAlignmentCenter;
    self.testTF.borderStyle = UITextBorderStyleLine;
    
    self.testTF.text = @"123456";
}


#pragma mark - UITextFieldDelegate




@end
