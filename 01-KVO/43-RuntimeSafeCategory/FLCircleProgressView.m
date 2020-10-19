//
//  FLCircleProgressView.m
//  FLCircleProgressView
//
//  Created by RomanticEncounter on 2019/6/14.
//  Copyright © 2019 FJL. All rights reserved.
//

#import "FLCircleProgressView.h"
//category
#import "NSString+FLTextSize.h"
#import "UIView+FLFrame.h"

@interface FLCircleProgressView ()

/**
 导轨layer
 */
@property (nonatomic, strong) CAShapeLayer *circleBackgroundLayer;

/**
 进度layer
 */
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer1;
@property (nonatomic, strong) CAShapeLayer *progressLayer2;
@property (nonatomic, strong) CAShapeLayer *progressLayer3;

/**
 半径
 */
@property (nonatomic, assign) CGFloat cornerRadius;

@end

@implementation FLCircleProgressView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _trackColor = [UIColor colorWithWhite:1 alpha:0.0];
        _lineWidth = 5;
        _progressColor = [UIColor grayColor];
        _progressLineCap = kCALineCapRound;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cornerRadius = MIN(self.fl_width, self.fl_height) * 0.5 - self.lineWidth * 0.5;
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    [super drawLayer:layer inContext:ctx];
    [self fl_drawCircleBackgroundLayer];
    [self fl_drawProgressLayer];
}

- (void)fl_drawCircleBackgroundLayer {
    //从 π/2 开始绘制一个圆形导轨
    CGPoint center = CGPointMake(self.fl_width * 0.5, self.fl_height * 0.5);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 2 endAngle:2 * M_PI + M_PI / 2 clockwise:YES];
    self.circleBackgroundLayer.path = circlePath.CGPath;
    
    [self.layer addSublayer:self.circleBackgroundLayer];
}

- (void)fl_drawProgressLayer {
    //从 π/2 开始绘制一个进度
    CGPoint center = CGPointMake(self.fl_width * 0.5, self.fl_height * 0.5);
    // 创建弧线路径 startAngle 开始角度  endAngle结束角度
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 120 endAngle:M_PI / 180 * 240 clockwise:YES];
    
    UIBezierPath *progressPath1 = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 240 endAngle: M_PI / 180 * 270  clockwise:YES];

    UIBezierPath *progressPath2 = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 270 endAngle: M_PI / 180 * 420  clockwise:YES];
    
    UIBezierPath *progressPath3 = [UIBezierPath bezierPathWithArcCenter:center radius:self.cornerRadius startAngle:M_PI / 180 * 420 endAngle:M_PI / 180 * 480 clockwise:YES];
    
    self.progressLayer.path = progressPath.CGPath;
    self.progressLayer.strokeStart = 0.0;
    self.progressLayer.strokeEnd = 1.0;
    [self.circleBackgroundLayer addSublayer:self.progressLayer];
    
    self.progressLayer1.path = progressPath1.CGPath;
    self.progressLayer1.strokeStart = 0.0;
    self.progressLayer1.strokeEnd = 1.0;
    [self.circleBackgroundLayer addSublayer:self.progressLayer1];

    self.progressLayer2.path = progressPath2.CGPath;
    self.progressLayer2.strokeStart = 0.0;
    self.progressLayer2.strokeEnd = 1.0;
//
    self.progressLayer3.path = progressPath3.CGPath;
//    self.progressLayer3.strokeStart = 0.0;
//    self.progressLayer3.strokeEnd = 1.0;
    
    [self.circleBackgroundLayer addSublayer:self.progressLayer];
    [self.circleBackgroundLayer addSublayer:self.progressLayer1];
    [self.circleBackgroundLayer addSublayer:self.progressLayer2];
    [self.circleBackgroundLayer addSublayer:self.progressLayer3];
}

#pragma mark - Setter
- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    self.circleBackgroundLayer.strokeColor = trackColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.circleBackgroundLayer.lineWidth = lineWidth;
    self.progressLayer.lineWidth = lineWidth;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.progressLayer.strokeEnd = progress;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgressLineCap:(CAShapeLayerLineCap)progressLineCap {
    _progressLineCap = progressLineCap;
    self.progressLayer.lineCap = progressLineCap;
}

#pragma mark - lazy load.

- (CAShapeLayer *)circleBackgroundLayer {
    if (!_circleBackgroundLayer) {
        _circleBackgroundLayer = [CAShapeLayer layer];
        _circleBackgroundLayer.lineWidth = self.lineWidth;
        _circleBackgroundLayer.strokeColor = self.trackColor.CGColor;
        _circleBackgroundLayer.fillColor = [UIColor clearColor].CGColor;
        _circleBackgroundLayer.lineCap = kCALineCapButt;
    }
    return _circleBackgroundLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.lineWidth = self.lineWidth;
        _progressLayer.strokeColor = self.progressColor.CGColor;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineCap = self.progressLineCap;
    }
    return _progressLayer;
}

- (CAShapeLayer *)progressLayer1 {
    if (!_progressLayer1) {
        _progressLayer1 = [CAShapeLayer layer];
        _progressLayer1.lineWidth = self.lineWidth;
        _progressLayer1.strokeColor = [UIColor redColor].CGColor;
        _progressLayer1.fillColor = [UIColor clearColor].CGColor;
        _progressLayer1.lineCap = self.progressLineCap;
    }
    return _progressLayer1;
}

- (CAShapeLayer *)progressLayer2 {
    if (!_progressLayer2) {
        _progressLayer2 = [CAShapeLayer layer];
        _progressLayer2.lineWidth = self.lineWidth;
        _progressLayer2.strokeColor = [UIColor blueColor].CGColor;
        _progressLayer2.fillColor = [UIColor clearColor].CGColor;
        _progressLayer2.lineCap = self.progressLineCap;
    }
    return _progressLayer2;
}

- (CAShapeLayer *)progressLayer3 {
    if (!_progressLayer3) {
        _progressLayer3 = [CAShapeLayer layer];
        _progressLayer3.lineWidth = self.lineWidth;
        _progressLayer3.strokeColor = [UIColor greenColor].CGColor;
        _progressLayer3.fillColor = [UIColor clearColor].CGColor;
        _progressLayer3.lineCap = self.progressLineCap;
    }
    return _progressLayer3;
}


@end
