//
//  HumidityView.h
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/10/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HumidityView : UIView

/// 设置湿度
/// @param value 湿度
/// @param isAnimation 是否执行动画
- (void)setHumidityValue:(CGFloat)value animation:(BOOL)isAnimation;
// 指针
@property (nonatomic, strong) UIImageView *pointer2;

@end

NS_ASSUME_NONNULL_END
