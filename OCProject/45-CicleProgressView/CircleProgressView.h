//
//  CircleProgressView.h
//  45-CicleProgressView
//
//  Created by XFB on 2020/10/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleProgressView : UIView

- (instancetype)initWithCircleProgressViewFrame:(CGRect)frame subTitle:(NSString *)subTitle;

// 百分比字符串
@property (nonatomic, assign) CGFloat progressFloat;

@end

NS_ASSUME_NONNULL_END
