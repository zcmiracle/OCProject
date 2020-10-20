//
//  TemperatureView.h
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/10/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TemperatureView : UIView

/// 设置温度
/// @param value 温度
/// @param isAnimation 是否执行动画
- (void)setTemperatureValue:(CGFloat)value animation:(BOOL)isAnimation;
// 指针
@property (nonatomic, strong) UIImageView *pointer2;

- (void)setTemperatureValue1:(CGFloat)value animation:(BOOL)isAnimation;

@end

NS_ASSUME_NONNULL_END
