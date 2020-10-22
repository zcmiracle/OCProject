//
//  CircleProgressView.m
//  45-CicleProgressView
//
//  Created by XFB on 2020/10/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "CircleProgressView.h"
#import "ZZCircleProgress.h"
// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface CircleProgressView ()

// 圆环进度条
@property (nonatomic, strong) ZZCircleProgress *progressView;
// 54.77% or 100%
@property (nonatomic, strong) UILabel *percentLabel;
// OEE1 or 点检完成率
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation CircleProgressView

- (instancetype)initWithCircleProgressViewFrame:(CGRect)frame subTitle:(NSString *)subTitle {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(7, 17, 43);
        
        // 圆环背景颜色
        UIColor *backgroundColor = RGB(18, 40, 93);
        // 填充颜色
        UIColor *fillColor = RGB(48, 111, 204);
        
        self.progressView = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(10, 0, 120, 135) pathBackColor:backgroundColor pathFillColor:fillColor startAngle:130 strokeWidth:10];
        // 是否显示圆点
        self.progressView.showPoint = NO;
        // 减少角度 80
        self.progressView.reduceAngle = 80;
        // 动画执行时间
        self.progressView.duration = 1.0;
        [self addSubview:self.progressView];
        
        // 54.77%
        _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, self.frame.size.width-40, 25)];
        _percentLabel.text = @"0.0%";
        _percentLabel.textColor = [UIColor whiteColor];
        _percentLabel.textAlignment = NSTextAlignmentCenter;
        _percentLabel.font = [UIFont boldSystemFontOfSize:24];
        [self addSubview:_percentLabel];
        
        // OEE1 or 点检完成率
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_percentLabel.frame) + 5, self.frame.size.width-60, 15)];
        _bottomLabel.text = subTitle;
        _bottomLabel.textColor = [UIColor whiteColor];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.font = [UIFont boldSystemFontOfSize:13];
        [self addSubview:_bottomLabel];
    }
    return self;
}

- (void)setProgressFloat:(CGFloat)progressFloat {
    _progressFloat = progressFloat;
    // 进度条progress
    _progressView.progress = progressFloat/100;
    
    _percentLabel.text = [NSString stringWithFormat:@"%.2f%%", progressFloat];
}


@end
