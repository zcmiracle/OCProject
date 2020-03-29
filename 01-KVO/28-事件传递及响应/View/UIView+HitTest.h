//
//  UIView+HitTest.h
//  28-事件传递及响应
//
//  Created by Fearless on 2020/3/29.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HitTest)

- (UIView *)zc_HitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end

NS_ASSUME_NONNULL_END
