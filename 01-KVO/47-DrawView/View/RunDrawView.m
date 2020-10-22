//
//  RunDrawView.m
//  ProductionCapacity
//
//  Created by XFB on 2020/10/22.
//  Copyright © 2020 Fearless. All rights reserved.
//  运行

#import "RunDrawView.h"
#import "UIView+Draw.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface RunDrawView ()

@property (nonatomic, strong) UIView *circleView;
// 356
@property (nonatomic, strong) UILabel *numberLabel;
// 运行
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation RunDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        [self addSubview:self.circleView];
        [self addSubview:self.numberLabel];
        [self addSubview:self.bottomLabel];
        
        // 横线
        [self zc_drawLineStartPoint:CGPointMake(15, height/2+0.5) endPoint:CGPointMake(width-29.5, height/2+0.5) lineColor:RGB(45, 142, 255) lineHeight:2];
        // 斜线
        [self zc_drawLineStartPoint:CGPointMake(width-30, height/2) endPoint:CGPointMake(width-10, 52) lineColor:RGB(45, 142, 255) lineHeight:2];
    }
    return self;
}

// 赋值
- (void)setNumberString:(NSString *)numberString {
    _numberString = numberString;
    self.numberLabel.text = numberString;
}

#pragma mark --- Lazy Loading
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, self.frame.size.width-40, 25)];
        _numberLabel.text = @"0";
        _numberLabel.font = [UIFont boldSystemFontOfSize:20];
        _numberLabel.textColor = RGB(45, 142, 255);
    }
    return _numberLabel;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, self.frame.size.width-40, 15)];
        _bottomLabel.text = @"运行";
        _bottomLabel.font = [UIFont systemFontOfSize:15];
        _bottomLabel.textColor = RGB(110, 110, 110);
    }
    return _bottomLabel;
}

- (UIView *)circleView {
    if (!_circleView) {
        CGFloat width = self.frame.size.width;
        _circleView =  [[UIView alloc] initWithFrame:CGRectMake(width-12, 50, 10, 10)];
        _circleView.backgroundColor = RGB(45, 142, 255);
        _circleView.layer.cornerRadius = 5;
        _circleView.clipsToBounds = YES;
    }
    return _circleView;
}

@end
