//
//  XFBWindow.m
//  28-事件传递及响应
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "XFBWindow.h"

@implementation XFBWindow

// 事件传递什么时候调用？
// 当事件传递给控件的时候，就会调用控件的这个方法，去寻找最合适的view

// 默认做法：寻找最合适的view
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    // 1、判断当前控件能否接收事件
    if (self.userInteractionEnabled == NO ||
        self.hidden == YES ||
        self.alpha <= 0.01) {
        return nil;
    }
    
    // 2、判断点在不在当前控件
    if ([self pointInside:point withEvent:event] == NO) return nil;
    
    // 3、从后往前遍历自己的子控件
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i --) {
        // 取出子控制器.
        UIView *childView = self.subviews[i];
        
        // 把当前控件上的坐标系转换成子控件上的坐标系
        CGPoint childP =  [self convertPoint:point toView:childView];
        UIView *tempView = [childView hitTest:childP withEvent:event];
        
        if (tempView) {
            return tempView;
        }
    }
    // 循环结束，表示没有比自己更合适的view
    return self;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return NO;
//}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
}
@end
