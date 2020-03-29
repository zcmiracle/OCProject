//
//  UIView+HitTest.m
//  28-事件传递及响应
//
//  Created by Fearless on 2020/3/29.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "UIView+HitTest.h"

@implementation UIView (HitTest)

- (UIView *)zc_HitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.alpha <= 0.01 ||
        !self.userInteractionEnabled ||
        self.hidden) {
        return nil;
    }
    
    // 判断当前点是否在view上
    if ([self pointInside:point withEvent:event]) {
        // 遍历子视图 倒序
        NSArray *subViews = [[self.subviews reverseObjectEnumerator] allObjects];
        UIView *tempView;
        
        for (UIView *subView in subViews) {
            // 转换坐标系。判断该点是否在bounds范围内
            CGPoint covertedPoint = [self convertPoint:point toView:subView];
            tempView = [subView zc_HitTest:covertedPoint withEvent:event];
        }
        // 如果转换在倒序遍历的view上，就返回，如果没有，直接返回self
        return  tempView ? tempView : self;
    } else {
        return nil;
    }
}

@end
