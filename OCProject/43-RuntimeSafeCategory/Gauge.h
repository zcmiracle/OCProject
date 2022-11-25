//
//  Gauge.h
//  43-RuntimeSafeCategory
//
//  Created by Fearless on 2020/10/19.
//  Copyright © 2020 Fearless. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Gauge : UIView
  
/// 设置温度
/// @param value 温度
/// @param isAnimation 是否执行动画
- (void)setTemperatureValue:(CGFloat)value animation:(BOOL)isAnimation;
// 指针
@property (nonatomic, strong) UIImageView *pointer2;


- (void)setTemperatureValue1:(CGFloat)value animation:(BOOL)isAnimation;

@end
