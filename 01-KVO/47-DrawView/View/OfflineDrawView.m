//
//  OfflineDrawView.m
//  ProductionCapacity
//
//  Created by XFB on 2020/10/22.
//  Copyright © 2020 Fearless. All rights reserved.
//  离线

#import "OfflineDrawView.h"
#import "UIView+Draw.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface OfflineDrawView ()

@property (nonatomic, strong) UIView *circleView;
// 41
@property (nonatomic, strong) UILabel *numberLabel;
// 离线
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation OfflineDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        [self addSubview:self.circleView];
        [self addSubview:self.numberLabel];
        [self addSubview:self.bottomLabel];
        
        // 横线
        [self zc_drawLineStartPoint:CGPointMake(29.5, height/2+0.5) endPoint:CGPointMake(width-15, height/2+0.5) lineColor:[UIColor whiteColor] lineHeight:2];
        // 斜线
        [self zc_drawLineStartPoint:CGPointMake(10, 52) endPoint:CGPointMake(30, height/2) lineColor:[UIColor whiteColor] lineHeight:2];
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
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-55, 5, 40, 25)];
        _numberLabel.text = @"0";
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.font = [UIFont boldSystemFontOfSize:20];
        _numberLabel.textColor = RGB(45, 142, 255);
    }
    return _numberLabel;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-55, 35, 40, 15)];
        _bottomLabel.text = @"离线";
        _bottomLabel.textAlignment = NSTextAlignmentRight;
        _bottomLabel.font = [UIFont systemFontOfSize:15];
        _bottomLabel.textColor = RGB(110, 110, 110);
    }
    return _bottomLabel;
}

- (UIView *)circleView {
    if (!_circleView) {
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(2, 50, 10, 10)];
        _circleView.backgroundColor = [UIColor whiteColor];
        _circleView.layer.cornerRadius = 5;
        _circleView.clipsToBounds = YES;
    }
    return _circleView;
}

@end
