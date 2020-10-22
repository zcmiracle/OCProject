//
//  UIView+Draw.h
//  ProductionCapacity
//
//  Created by XFB on 2020/10/22.
//  Copyright © 2020 Fearless. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Draw)

/// 画线
/// @param startPoint 起始点坐标
/// @param endPoint 结束点坐标
/// @param lineColor 线条颜色
/// @param lineHeight 线条宽度
- (void)zc_drawLineStartPoint:(CGPoint)startPoint
                     endPoint:(CGPoint)endPoint
                    lineColor:(UIColor *)lineColor
                   lineHeight:(CGFloat)lineHeight;

@end

NS_ASSUME_NONNULL_END
