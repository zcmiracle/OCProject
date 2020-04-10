//
//  BasicAnimationViewController.m
//  39-动画Animation
//
//  Created by XFB on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "BasicAnimationViewController.h"

@interface BasicAnimationViewController () <CAAnimationDelegate>

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation BasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.layer = [CALayer layer];
    self.layer.backgroundColor = [UIColor greenColor].CGColor;
    self.layer.frame = CGRectMake(150, 200, 100, 100);
    [self.view.layer addSublayer:self.layer];
}

// 缩放
- (IBAction)scaleButtonClick:(UIButton *)sender {
    self.animation = [CABasicAnimation animation];
    self.animation.keyPath = @"bounds";
    self.animation.toValue = [NSValue valueWithCGRect:CGRectMake(150, 100, 200, 200)];
    self.animation.duration = 2.0f;
//    self.animation.delegate = self;
//    self.animation.removedOnCompletion = NO;
//    self.animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:self.animation forKey:nil];
}

// 3D旋转
- (IBAction)rotationButtonClick:(UIButton *)sender {
    self.animation = [CABasicAnimation animation];
    self.animation.keyPath = @"transform";
    self.animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
    self.animation.duration = 2.0f;
//    self.animation.delegate = self;
//    self.animation.removedOnCompletion = NO;
//    self.animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:self.animation forKey:nil];
}

// 位移  byValue是增加多少
- (IBAction)transformXYButtonClick:(UIButton *)sender {
    self.animation = [CABasicAnimation animation];
//    self.animation.keyPath = @"transform.rotation";
//    self.animation.fromValue = [NSValue valueWithCGRect:CGRectMake(150, 100, 200, 200)];
//    self.animation.toValue = @(M_PI_2);
    
    //    self.animation.keyPath = @"transform.translation.x";
    //    self.animation.toValue = @(100);
    
    self.animation.keyPath = @"position";
    self.animation.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    self.animation.duration = 2.0f;
    //    self.animation.delegate = self;
    //    self.animation.removedOnCompletion = NO;
    //    self.animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:self.animation forKey:nil];
}

// 背景色
- (IBAction)bgColorButtonClick:(UIButton *)sender {
    self.animation = [CABasicAnimation animation];
    self.animation.keyPath = @"backgroundColor";
    self.animation.fromValue = (__bridge id)[UIColor lightGrayColor].CGColor;
    self.animation.toValue = (__bridge id)[UIColor redColor].CGColor;
    self.animation.duration = 2.0f;
//    self.animation.delegate = self;
    /**
     removedOnCompletion 和 fillMode
     一起使用才能让 图层保持动画执行完毕后的状态
     */
    // 动画执行完毕后 不要删除动画
//    self.animation.removedOnCompletion = NO;
//    // 动画完成后 保持最新状态
//    self.animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:self.animation forKey:nil];
}

// 透明度
- (IBAction)alphaButtonClick:(UIButton *)sender {

    
}

@end
