//
//  UIView+Draw.m
//  ProductionCapacity
//
//  Created by XFB on 2020/10/22.
//  Copyright © 2020 Fearless. All rights reserved.
//

#import "UIView+Draw.h"

@implementation UIView (Draw)

/// 画线
/// @param startPoint 起始点坐标
/// @param endPoint 结束点坐标
/// @param lineColor 线条颜色
/// @param lineHeight 线条宽度
- (void)zc_drawLineStartPoint:(CGPoint)startPoint
                     endPoint:(CGPoint)endPoint
                    lineColor:(UIColor *)lineColor
                   lineHeight:(CGFloat)lineHeight {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (lineColor) {
        shapeLayer.strokeColor = lineColor.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
        path.CGPath;
    });
    shapeLayer.lineWidth = lineHeight;
    [self.layer addSublayer:shapeLayer];
}

@end
