//
//  YellowViewColor.m
//  28-事件传递及响应
//
//  Created by Fearless on 2020/3/29.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "YellowViewColor.h"
#import "UIView+HitTest.h"

@implementation YellowViewColor

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return [super pointInside:point withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"%s", __func__);
    return [self zc_HitTest:point withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Yellow --- touchBegan");
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Yellow --- touchesMoved");
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Yellow --- touchesEnded");
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Yellow --- touchesCancelled");
    [super touchesCancelled:touches withEvent:event];
}

@end
