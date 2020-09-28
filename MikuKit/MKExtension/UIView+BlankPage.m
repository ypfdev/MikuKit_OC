//
//  UIView+BlankPage.m
//  MotionCamera
//
//  Created by SongYang on 2018/12/26.
//  Copyright © 2018 Galanz. All rights reserved.
//

#import "UIView+BlankPage.h"

NSInteger blankTag = 11111;
NSInteger blankImgTag = 111111;
NSInteger blankLabTag = 222222;
NSInteger blankBtnTag = 333333;

@implementation UIView (BlankPage)

- (UIView *)blankPage{
    UIView* blank = [self viewWithTag:blankTag];
    if (!blank) {
        blank = [[UIView alloc] init];
        blank.backgroundColor = [UIColor mk_colorWithHex:0xF2F2F2];
        blank.tag = blankTag;
        [self addSubview:blank];
    }
    return blank;
}

- (UIImageView *)img{
    UIImageView* img = [self.blankPage viewWithTag:blankImgTag];
    if (!img) {
        img = [UIImageView new];
        img.tag = blankImgTag;
        [self.blankPage addSubview:img];
    }
    return img;
}

- (UILabel *)lab{
    UILabel* lab = [self.blankPage viewWithTag:blankLabTag];
    if (!lab) {
        lab = [UILabel new];
        lab.numberOfLines = 0;
        lab.tag = blankLabTag;
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = [MCTheme primaryTextColor];
        [self.blankPage addSubview:lab];
    }
    return lab;
}

- (UIButton *)refreshBtn{
    UIButton* btn = [self.blankPage viewWithTag:blankBtnTag];
    if (!btn) {
        btn = [UIButton new];
        btn.tag = blankBtnTag;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:@"刷新" forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(7, 24, 7, 24);
        [btn setTitleColor:[UIColor mk_colorWithHex:0x626262] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 1;
        btn.layer.borderColor = [UIColor mk_colorWithHex:0xD8D8D8].CGColor;
        btn.layer.borderWidth = 1;
        [btn sizeToFit];
        btn.layer.cornerRadius = btn.bounds.size.height*0.5;
        [self.blankPage addSubview:btn];
    }
    return btn;
}

- (void)layoutBlank{
    [self.blankPage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.size.equalTo(self);
    }];
    
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.blankPage);
        make.centerY.equalTo(self.blankPage).multipliedBy(459/603.0);
        make.height.width.equalTo(self.blankPage.mas_width).multipliedBy(143/375.0);
    }];
    
    [self.lab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.blankPage);
        make.top.equalTo(self.img.mas_bottom).offset(15);
        make.height.equalTo(@14);
    }];
    UIButton* btn = [self.blankPage viewWithTag:blankBtnTag];
    if (btn) [btn removeFromSuperview];
    
    [self bringSubviewToFront:self.blankPage];
}

- (void)layoutNoNetwork{
    [self.blankPage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.size.equalTo(self);
    }];
    
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.blankPage);
        make.bottom.equalTo(self.blankPage).multipliedBy(268.5/603.0);
        make.height.width.equalTo(self.blankPage.mas_width).multipliedBy(143/375.0);
    }];
    
    [self.lab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.blankPage);
        make.top.equalTo(self.img.mas_bottom).offset(15);
    }];
    
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.blankPage);
        make.top.equalTo(self.lab.mas_bottom).offset(30);
    }];
    
    [self bringSubviewToFront:self.blankPage];
}

- (void)setBlankImageName:(NSString *)imgName titleName:(NSString *)title{
    UILabel* lab = self.lab;
    lab.text = title;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [MCTheme primaryTextColor];
    self.img.image = [UIImage imageNamed:imgName];
    self.blankPage.hidden = NO;
    [self layoutBlank];
}


- (void)noNetworkWithRefreshBlock:(void(^)(void))refresh{
    self.blankPage.hidden = NO;
    self.img.image = [UIImage imageNamed:@"blank_no_network"];
    NSMutableParagraphStyle* style = [NSMutableParagraphStyle new];
    style.lineSpacing = 10;
    style.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString* arrStr = [[NSMutableAttributedString alloc] initWithString:@"网络竟然崩溃了" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor mk_colorWithHex:0x9B9B9B]}];
    [arrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n别紧张，试试看刷新" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor mk_colorWithHex:0xB2B2B2]}]];
    self.lab.attributedText = arrStr;
    
#warning 这里临时注释掉RAC
    if (![self.blankPage viewWithTag:blankBtnTag]) {
//        [[self.refreshBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            if (refresh) {
//                refresh();
//            }
//        }];
    }
    [self layoutNoNetwork];
}

- (void)showDefaultBlankContent{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [[self.blankPage viewWithTag:blankImgTag] removeFromSuperview];
    [[self.blankPage viewWithTag:blankBtnTag] removeFromSuperview];
    self.blankPage.hidden = NO;
    self.lab.text = @"暂无内容";
    self.lab.font = [UIFont systemFontOfSize:20];
    self.lab.textColor = [MCTheme primaryTextColor];
    [self.lab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
}
@end
