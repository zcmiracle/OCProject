//
//  BaseView.m
//  28-事件传递及响应
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@ ---> 调用touchesBegan", [self class]);
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

//    NSLog(@"调用顺序---%@", [self class]);
    
    // 1、查看自己能不能接收事件
    // 1、判断当前控件能否接收事件
    if (self.userInteractionEnabled == NO ||
        self.hidden == YES ||
        self.alpha <= 0.01){
        return nil;
    }
    
    // 2、判断当前的点在不在自己身上.
    // 2、判断点在不在当前控件
    if ([self pointInside:point withEvent:event] == NO) return nil;
    
    // 3、查看自己是不是最适合的view
    // 3、从后往前遍历自己的子控件
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i --) {
        // 取出子控制器.
        UIView *childView = self.subviews[i];
        
        // 要把当前的点转换成子控件上的坐标点.
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

@end
