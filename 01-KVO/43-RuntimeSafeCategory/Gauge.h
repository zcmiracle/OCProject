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
@property (nonatomic, strong) CAShapeLayer *progressLayer;

- (void)setGaugeValue:(CGFloat)value animation:(BOOL)isAnim;

@end
