//
//  AnimationDelegateController.m
//  39-动画Animation
//
//  Created by XFB on 2020/4/8.
//  Copyright © 2020 XFB. All rights reserved.
//  动画代理

#import "AnimationDelegateController.h"
#import "BezierPathViewController.h"

@interface AnimationDelegateController () <CAAnimationDelegate>

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation AnimationDelegateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.layer = [CALayer layer];
    self.layer.backgroundColor = [UIColor greenColor].CGColor;
    self.layer.frame = CGRectMake(150, 200, 100, 100);
    [self.view.layer addSublayer:self.layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//        [self testBackgroundColor];
//        [self testScale];
//        [self testTransform3DRotate];
//        [self testTransform];
    [self testTranlate];
}

- (void)testTranlate {
    // 1、创建动画对象
    self.animation = [CABasicAnimation animation];
    // 2、设置动画对象 keyPath决定了执行怎样的动画 KVC，调整哪个属性来执行动画
    
    self.animation.keyPath = @"position";
    // byValue：增加多少值
    // tovalue：最终变成什么值
    self.animation.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    // 设置动画时间
    self.animation.duration = 3.0f;
    // 设置代理
    self.animation.delegate = self;
    
    self.animation.removedOnCompletion = NO;
    self.animation.fillMode = kCAFillModeForwards;
    
    // 3、添加动画
    [self.layer addAnimation:self.animation forKey:nil];
}

// 平移
- (void)testTransform {
    
    // 1、创建动画对象
    self.animation = [CABasicAnimation animation];
    // 2、设置动画对象 keyPath决定了执行怎样的动画 KVC，调整哪个属性来执行动画
    //    self.animation.keyPath = @"transform.rotation";
    //    self.animation.fromValue = [NSValue valueWithCGRect:CGRectMake(150, 100, 200, 200)];
    //    self.animation.toValue = @(M_PI_2);
    
    self.animation.keyPath = @"transform.translation.x";
    self.animation.toValue = @(100);
    
    // 设置动画时间
    self.animation.duration = 3.0f;
    // 设置代理
    self.animation.delegate = self;
    
    self.animation.removedOnCompletion = NO;
    self.animation.fillMode = kCAFillModeForwards;
    
    // 3、添加动画
    [self.layer addAnimation:self.animation forKey:nil];
    
}

// 3D旋转
- (void)testTransform3DRotate {
    // 1、创建动画对象
    self.animation = [CABasicAnimation animation];
    // 2、设置动画对象 keyPath决定了执行怎样的动画 KVC，调整哪个属性来执行动画
    self.animation.keyPath = @"transform";
    //    self.animation.fromValue = [NSValue valueWithCGRect:CGRectMake(150, 100, 200, 200)];
    self.animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
    // 设置动画时间
    self.animation.duration = 3.0f;
    // 设置代理
    self.animation.delegate = self;
    
    self.animation.removedOnCompletion = NO;
    self.animation.fillMode = kCAFillModeForwards;
    
    // 3、添加动画
    [self.layer addAnimation:self.animation forKey:nil];
}

// 形变
- (void)testScale {
    // 1、创建动画对象
    self.animation = [CABasicAnimation animation];
    // 2、设置动画对象 keyPath决定了执行怎样的动画 KVC，调整哪个属性来执行动画
    self.animation.keyPath = @"bounds";
    //    self.animation.fromValue = [NSValue valueWithCGRect:CGRectMake(150, 100, 200, 200)];
    self.animation.toValue = [NSValue valueWithCGRect:CGRectMake(150, 100, 200, 200)];
    // 设置动画时间
    self.animation.duration = 3.0f;
    // 设置代理
    self.animation.delegate = self;
    
    self.animation.removedOnCompletion = NO;
    self.animation.fillMode = kCAFillModeForwards;
    
    // 3、添加动画
    [self.layer addAnimation:self.animation forKey:nil];
}

// 测试背景颜色的修改
- (void)testBackgroundColor {
    // 1、创建动画对象
    self.animation = [CABasicAnimation animation];
    // 2、设置动画对象 keyPath决定了执行怎样的动画 KVC，调整哪个属性来执行动画
    self.animation.keyPath = @"backgroundColor";
    self.animation.fromValue = (__bridge id)[UIColor lightGrayColor].CGColor;
    self.animation.toValue = (__bridge id)[UIColor redColor].CGColor;
    // 设置动画时间
    self.animation.duration = 3.0f;
    // 设置代理
    self.animation.delegate = self;
    
    /**
     removedOnCompletion 和 fillMode
     一起使用才能让 图层保持动画执行完毕后的状态
     */
    // 动画执行完毕后 不要删除动画
    self.animation.removedOnCompletion = NO;
    // 动画完成后 保持最新状态
    self.animation.fillMode = kCAFillModeForwards;
    
    // 3、添加动画
    [self.layer addAnimation:self.animation forKey:nil];
}


//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    if (anim == self.animation) {
        NSLog(@"两个相同的动画animation");
    }
    
    // iOS13后没有
    if ([anim.keyPath isEqualToString:@"backgroundColor"]) {
        NSLog(@"背景颜色改变");
    }
}

@end
