//
//  MCSectorProgressView.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/11/4.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCSectorProgressView.h"

@implementation MCSectorProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.progressLabel = [[UILabel alloc] initWithFrame:frame];
        self.progressLabel.textColor = [UIColor whiteColor];
        self.progressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        self.progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.progressLabel];
        [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // 中心点
    CGPoint origin = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    // 半径
    CGFloat radius = (rect.size.width - 1) * 0.5;   // 减1是为了防止弧线被切
    
    // 绘制背景弧线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:origin radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    // 设置线宽
    circlePath.lineWidth = 0.5f;
    // 填充颜色
    [[UIColor mk_colorWithHex:0xFFFFFF alpha:0.7] set];
    [circlePath stroke];
    
    // 绘制进度弧线
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = startAngle + self.progress * M_PI * 2;
    UIBezierPath *sectorPath = [UIBezierPath bezierPathWithArcCenter:origin radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    // 从弧线结束为止绘制一条线段到圆心。这样系统会自动闭合图形，绘制一条从圆心到弧线起点的线段。
    [sectorPath addLineToPoint:origin];
    // 设置线宽
    sectorPath.lineWidth = 0.5f;
    // 填充颜色
    [[UIColor mk_colorWithHex:0xFE7B21 alpha:0.7] set];
    [sectorPath fill];      // 路径内部闭合区域
    [sectorPath stroke];    // 路径线条本身
}

- (BOOL)isExclusiveTouch {
    return YES;
}
 

/// 重写progress的set方法，可以在赋值的同时给label赋值
/// @param progress 进度值
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%0.2f%%",progress * 100];
    // 赋值结束后要刷新UI，不然看不到扇形变化
    [self setNeedsDisplay];
}


@end
