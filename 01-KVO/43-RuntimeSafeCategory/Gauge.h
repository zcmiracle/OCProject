//
//  Gauge.h
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/10/19.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
  
@interface Gauge : UIView {
    
    CGFloat maxNum;
    CGFloat minNum;
      
    CGFloat maxAngle;
    CGFloat minAngle;
      
    CGFloat gaugeValue;
    CGFloat gaugeAngle;
      
    CGFloat angleperValue;
    CGFloat scoleNum;
}
  
@property (nonatomic, strong) UIImage *gaugeView;
@property (nonatomic, strong) UIImageView *pointer2;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic) CGContextRef context;
/** 进度条layer */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

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
 导轨背景色
 */
@property (nonatomic, strong) UIColor *trackColor;

/**
 线条宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 进度条颜色
 */
@property (nonatomic, strong) UIColor *progressColor;

/**
 进度条类型
 */
@property (nonatomic, copy) CAShapeLayerLineCap progressLineCap;

/**
 进度
 */
@property (nonatomic, assign) CGFloat progress;


/**
 半径
 */
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIView *view;

- (void)setGaugeValue:(CGFloat)value animation:(BOOL)isAnim;

@end
