//
//  GPSearchFilterCLCell.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/27.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "GPSearchFilterCLCell.h"

#define SelectedColor [UIColor mk_colorWithHex:0xFF1832 alpha:1.0f]     // item被选中的主题色
#define SelectedBGColor UIColor.whiteColor                            // item被选中的背景色

#define DeselectedColor [UIColor mk_colorWithHex:0x222222 alpha:1.0f]   // item取消选中的主题色
#define DeselectedBGColor [UIColor mk_colorWithHex:0xF5F5F5 alpha:1.0f] // item取消选中的背景色

@interface GPSearchFilterCLCell ()

@property (nonatomic, strong) UILabel *propertyLabel;

@end

@implementation GPSearchFilterCLCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews {
    self.backgroundColor = [UIColor mk_randomColor];
    
    _propertyLabel = [[UILabel alloc] init];
    [self addSubview:_propertyLabel];
    [_propertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kAdaptedWidth(5));
        make.left.equalTo(self).offset(kAdaptedWidth(5));
        make.bottom.equalTo(self).offset(kAdaptedWidth(-5));
        make.right.equalTo(self).offset(kAdaptedWidth(-5));
    }];
    
    _propertyLabel.backgroundColor = DeselectedBGColor;
    _propertyLabel.text = @"xxxxx";
    _propertyLabel.textColor = DeselectedColor;
    _propertyLabel.textAlignment = NSTextAlignmentCenter;
    _propertyLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    
    _propertyLabel.layer.masksToBounds = YES;
    _propertyLabel.layer.cornerRadius = 10.0f;
    
    _propertyLabel.layer.borderWidth = 0.5f;
    _propertyLabel.layer.borderColor = DeselectedColor.CGColor;
    
}


- (void)setSelected:(BOOL)selected {
//    self.selected = selected;
    // 被选中
    if (selected) {
        self.propertyLabel.textColor = SelectedColor;
        self.propertyLabel.layer.borderColor = SelectedColor.CGColor;
        self.backgroundColor = SelectedBGColor;
        
    } else {
        self.propertyLabel.textColor = DeselectedColor;
        self.propertyLabel.layer.borderColor = UIColor.clearColor.CGColor;
        self.backgroundColor = DeselectedBGColor;
    }
}


@end
