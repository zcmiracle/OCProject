//
//  White.m
//  28-事件传递及响应
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "White.h"

@implementation White

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [super touchesBegan:touches withEvent:event];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    return [super hitTest:point withEvent:event];
//}

@end
