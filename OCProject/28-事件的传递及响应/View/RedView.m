
//
//  RedView.m
//  28-事件传递及响应
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "RedView.h"

@implementation RedView

// touchesBegan 默认做法：将事件传递上一个响应者
// 红色的上一个响应者是绿色，默认上一个响应者是父控件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSLog(@"%s", __func__);
    [super touchesBegan:touches withEvent:event];
}

@end
