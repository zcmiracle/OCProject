//
//  CustomView.m
//  35-控制器加载和UI初始化过程
//
//  Created by Fearless on 2020/4/5.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/**
 init 封装了initWithFrame
 xib 初始化的时候执行 initWithCorder + awakeFromNib
 
 */
- (instancetype)init {
    NSLog(@"%s", __func__);
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"%s", __func__);
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"%s", __func__);
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    NSLog(@"%s", __func__);
    [super awakeFromNib];
}

- (void)layoutSubviews {
    NSLog(@"%s", __func__);
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"%s", __func__);
    
    // 绘制 coreGraphic
    // 获取当前的上下文
    // 全局的堆栈 stack 存放上下文的CGContextRef
    // 入栈
    // UIGraphicsPushContext(nil)
    // 出栈
    // UIGraphicsPopContext();
    
    // UIView
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIGraphicsPopContext();
//    CGContextRef context2 = UIGraphicsGetCurrentContext();
    // 获取当前的上下文，获取stack上的上下文
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:20 startAngle:0 endAngle:M_PI clockwise:YES];
    // 绘制在当前栈上的
    [path stroke];

    
    
}


@end
