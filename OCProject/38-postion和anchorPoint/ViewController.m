//
//  ViewController.m
//  38-postion和anchorPoint
//
//  Created by XFB on 2020/4/8.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *orangeView;
@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) CALayer *orangeLayer;
@property (nonatomic, strong) CALayer *redLayer;

@end

@implementation ViewController

- (IBAction)changeAnchorPoint:(UIButton *)sender {
    
//    [self switchButtonView:sender];
    [self switchButtonLayer:sender];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self anchorPointView];
    [self anchorPointLayer];
    
    // anchorPoint 是锚点，范围是(0~1)：相对于layer本身的坐标
    // 改变anchorPoint会改变frame，但是position不会改变（anchorPoint值的改变，可以改变view的布局）
}

- (void)anchorPointView {
    self.orangeView = [[UIView alloc] init];
    self.orangeView.frame = CGRectMake(100, 200, 200, 200);
    self.orangeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.orangeView];
    
    self.redView = [[UIView alloc] init];
    self.redView.frame = CGRectMake(0, 0, 100, 100);
    self.redView.layer.position = CGPointZero;
    self.redView.backgroundColor = [UIColor redColor];
    [self.orangeView addSubview:self.redView];
    
    // postion相对自身坐标？
    NSLog(@"orangeView.position = %@", NSStringFromCGPoint(self.orangeView.layer.position));
    NSLog(@"redView.position = %@", NSStringFromCGPoint(self.redView.layer.position));
    
    // 默认锚点 {0.5, 0.5} 相对于父视图？
    NSLog(@"orangeView.anchorPoint = %@", NSStringFromCGPoint(self.orangeView.layer.anchorPoint));
    NSLog(@"redView.anchorPoint = %@", NSStringFromCGPoint(self.redView.layer.anchorPoint));
}

- (void)anchorPointLayer {
    self.orangeLayer = [[CALayer alloc] init];
    self.orangeLayer.frame = CGRectMake(100, 200, 200, 200);
    self.orangeLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:self.orangeLayer];
    
    self.redLayer = [[CALayer alloc] init];
    self.redLayer.frame = CGRectMake(0, 0, 100, 100);
    self.redLayer.position = CGPointZero;
    self.redLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.orangeLayer addSublayer:self.redLayer];
    
    // postion相对自身坐标？
    NSLog(@"orangeLayer.position = %@", NSStringFromCGPoint(self.orangeLayer.position));
    NSLog(@"redLayer.position = %@", NSStringFromCGPoint(self.redLayer.position));
    
    // 默认锚点 {0.5, 0.5} 相对于父视图？
    NSLog(@"orangeLayer.anchorPoint = %@", NSStringFromCGPoint(self.orangeLayer.anchorPoint));
    NSLog(@"redLayer.anchorPoint = %@", NSStringFromCGPoint(self.redLayer.anchorPoint));
}

- (void)switchButtonView:(UIButton *)sender {
    switch (sender.tag) {
        case 1000: // anchorPoint(0, 0)
            self.redView.layer.anchorPoint = CGPointMake(0, 0);
            break;
        case 1001: // anchorPoint(0.5, 0.5)
            self.redView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            break;
        case 1002: // anchorPoint(0, 0.5)
            self.redView.layer.anchorPoint = CGPointMake(0, 0.5);
            break;
        case 1003: // anchorPoint(0.5, 0)
            self.redView.layer.anchorPoint = CGPointMake(0.5, 0);
            break;
        case 1004: // anchorPoint(1, 0)
            self.redView.layer.anchorPoint = CGPointMake(1, 0);
            break;
        case 1005: // anchorPoint(0, 1)
            self.redView.layer.anchorPoint = CGPointMake(0, 1);
            break;
        case 1006: // anchorPoint(1, 1)
            self.redView.layer.anchorPoint = CGPointMake(1, 1);
            break;
        default:
            break;
    }
    [self.redView setNeedsDisplay];
}

- (void)switchButtonLayer:(UIButton *)sender {
    switch (sender.tag) {
        case 1000: // anchorPoint(0, 0)
            self.redLayer.anchorPoint = CGPointMake(0, 0);
            break;
        case 1001: // anchorPoint(0.5, 0.5)
            self.redLayer.anchorPoint = CGPointMake(0.5, 0.5);
            break;
        case 1002: // anchorPoint(0, 0.5)
            self.redLayer.anchorPoint = CGPointMake(0, 0.5);
            break;
        case 1003: // anchorPoint(0.5, 0)
            self.redLayer.anchorPoint = CGPointMake(0.5, 0);
            break;
        case 1004: // anchorPoint(1, 0)
            self.redLayer.anchorPoint = CGPointMake(1, 0);
            break;
        case 1005: // anchorPoint(0, 1)
            self.redLayer.anchorPoint = CGPointMake(0, 1);
            break;
        case 1006: // anchorPoint(1, 1)
            self.redLayer.anchorPoint = CGPointMake(1, 1);
            break;
        default:
            break;
    }
    [self.redLayer setNeedsDisplay];
}


@end
