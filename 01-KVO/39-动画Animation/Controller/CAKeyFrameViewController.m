
//
//  CAKeyFrameViewController.m
//  39-动画Animation
//
//  Created by XFB on 2020/4/8.
//  Copyright © 2020 XFB. All rights reserved.
//  关键帧动画 核心动画

#import "CAKeyFrameViewController.h"

@interface CAKeyFrameViewController () <CAAnimationDelegate>

// 飞机图片layer层
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
// 路径
@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation CAKeyFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:CGPointMake(40, 175)];
    [self.path addCurveToPoint:CGPointMake(300, 175)
                 controlPoint1:CGPointMake(50, 40)
                 controlPoint2:CGPointMake(200, 300)];
    pathLayer.path = self.path.CGPath;
    pathLayer.lineWidth = 2.0f;
    pathLayer.fillColor = [UIColor orangeColor].CGColor;
    [pathLayer setStrokeColor:[UIColor redColor].CGColor];
    [self.view.layer addSublayer:pathLayer];
    
    // 飞机图片，其实可以用UIImageView代替
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.contents = (__bridge id)[UIImage imageNamed:@"plane"].CGImage;
    self.shapeLayer.bounds = CGRectMake(0, 0, 50, 50);
    self.shapeLayer.position = CGPointMake(40, 175);
    [self.view.layer addSublayer:self.shapeLayer];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 创建动画对象
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    // 设置动画对象 keyPath
    keyFrameAnimation.keyPath = @"position";
    // 动画执行时间
    keyFrameAnimation.duration = 3.0;
    // 自动旋转
    keyFrameAnimation.rotationMode = kCAAnimationRotateAuto;
    
    keyFrameAnimation.calculationMode = kCAAnimationCubicPaced;
    
    // 动画路径
    keyFrameAnimation.path = self.path.CGPath;
    // 该路径下时间
    keyFrameAnimation.keyTimes = @[@(0.7), @(0.4), @(0.9)];
    // 分段
    keyFrameAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(60, 200)],
                                 [NSValue valueWithCGPoint:CGPointMake(100, 200)],
                                 [NSValue valueWithCGPoint:CGPointMake(140, 200)]];
    [self.shapeLayer addAnimation:keyFrameAnimation forKey:nil];
}


@end
