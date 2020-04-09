
//
//  TransitionViewController.m
//  39-动画Animation
//
//  Created by XFB on 2020/4/8.
//  Copyright © 2020 XFB. All rights reserved.
//  过渡转场动画

#import "TransitionViewController.h"

@interface TransitionViewController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.contents = (__bridge id)[UIImage imageNamed:@"plane"].CGImage;
    self.shapeLayer.frame = CGRectMake(100, 100, 50, 50);
    [self.view.layer addSublayer:self.shapeLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CATransition *transitionAnim = [CATransition animation];
    transitionAnim.type = @"cube";
    transitionAnim.subtype = kCATransitionFromRight;
    transitionAnim.duration = 2.0;
    [self.shapeLayer addAnimation:transitionAnim forKey:nil];
    
    self.shapeLayer.contents = (__bridge id)[UIImage imageNamed:@"test"].CGImage;
}

@end
