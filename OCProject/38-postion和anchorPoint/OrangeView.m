//
//  OrangeView.m
//  38-postion和anchorPoint
//
//  Created by XFB on 2020/10/16.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "OrangeView.h"

@implementation OrangeView


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return [super pointInside:point withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    /**
     1、`hitTest`会来调用`pointInside`
     2、根据`pointInside`的值来做不同处理：如果`pointInside`为`YES`，
        那么**反序遍历子view**，如果`pointInside`为`NO`，返回`nil`
     3、如果点击区域在自己，而不是在子View里面，返回的是自己
     4、如果点击区域在子View里面，返回的是子View
     */
    return [self zcHitTest:point withEvent:event];
}

- (UIView *)zcHitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.alpha <= 0.01 || !self.userInteractionEnabled || self.hidden) {
        return nil;
    }
    
    if ([self pointInside:point withEvent:event]) { // 在我的bounds范围内
        // 反序遍历子view
        NSArray *subViews = [[self.subviews reverseObjectEnumerator] allObjects];
        for (UIView *subView in subViews) {
            // 转换坐标系
            CGPoint convertPoint = [self convertPoint:point toView:subView];
//            if ([subView pointInside:convertPoint withEvent:event]) {
//                return subView;
//            }
            [self zcHitTest:convertPoint withEvent:event];
            
        }
        return self;
    } else {
        return nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

@end
