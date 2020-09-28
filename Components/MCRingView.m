//
//  MCRingView.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/8/30.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCRingView.h"

@interface MCRingView ()

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *ringColor;
@property (nonatomic, assign) CGFloat ringWidth;

@end

@implementation MCRingView

- (instancetype)initWithRingColor:(UIColor *)ringColor ringWidth:(CGFloat)ringWidth {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.ringColor = ringColor;
        self.ringWidth = ringWidth;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // 画指定线条宽度的圆环
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.origin.x + rect.size.width * 0.5, rect.origin.y + rect.size.height * 0.5) radius:(rect.size.width - self.ringWidth) * 0.5 startAngle:0 * M_PI endAngle:2 * M_PI clockwise:YES];
    path.lineWidth = self.ringWidth;
    
    // 填充颜色
    [self.ringColor set];
    [path stroke];
    
//    // 画直线
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(10, 10)];
//    [path addLineToPoint:CGPointMake(200, 80)];
//
//    path.lineWidth = 5.0;
//    path.lineCapStyle = kCGLineCapRound; //线条拐角
//    path.lineJoinStyle = kCGLineJoinRound; //终点处理
//
//    [path stroke];
    
}

@end
