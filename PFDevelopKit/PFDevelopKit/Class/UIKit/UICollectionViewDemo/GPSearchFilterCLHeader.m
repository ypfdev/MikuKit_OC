//
//  GPSearchFilterCLHeader.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/27.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "GPSearchFilterCLHeader.h"

@interface GPSearchFilterCLHeader ()

@property (nonatomic, strong) UILabel *sectionTitleLabel;
@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIImageView *allTag;

@end

@implementation GPSearchFilterCLHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}


- (void)initSubviews {
    
    _sectionTitleLabel = [[UILabel alloc] init];
    [self addSubview:_sectionTitleLabel];
    [_sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kAdaptedWidth(5));
        make.left.equalTo(self).offset(kAdaptedWidth(5));
        make.bottom.equalTo(self).offset(kAdaptedWidth(-5));
        make.right.equalTo(self).offset(kAdaptedWidth(-60));
    }];
    _sectionTitleLabel.text = @"组名";
    _sectionTitleLabel.textColor = [UIColor mk_colorWithHex:0x333333 alpha:1.0f];
    _sectionTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Bold" size:15];
    
    
    _allTag = [[UIImageView alloc] init];
    [self addSubview:_allTag];
    [_allTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kAdaptedWidth(-10));
        make.centerY.equalTo(self);
        make.height.width.mas_equalTo(kAdaptedWidth(10));
    }];
    _allTag.image = [UIImage imageNamed:@"img_searchFilter_fold"];
    
    
    _allLabel = [[UILabel alloc] init];
    [self addSubview:_allLabel];
    [_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.sectionTitleLabel); make.right.equalTo(self.allTag.mas_left).offset(kAdaptedWidth(-10));
        make.width.mas_equalTo(kAdaptedWidth(30));
    }];
    _allLabel.text = @"全部";
    _allLabel.textColor = [UIColor mk_colorWithHex:0xC0C0C0 alpha:1.0f];
    _allLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    
    
}





@end
