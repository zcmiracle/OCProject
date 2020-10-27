//
//  HorizontalBarView.m
//  46-ProductCapacity
//
//  Created by Fearless on 2020/10/27.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "HorizontalBarView.h"

@interface HorizontalBarView ()

/// 銑削B141檢驗與包裝
@property (nonatomic, strong) UILabel *titleLabel;
/// 318
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation HorizontalBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(8, 17, 42);
        [self addSubview:self.titleLabel];
        [self addSubview:self.numberLabel];
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    
    self.titleLabel.text = dataDict[@"type"];
    self.numberLabel.text = dataDict[@"number"];
    
    int number = [dataDict[@"number"] intValue];
    
    CGFloat totalW = self.bounds.size.width;
    self.lineView.frame = CGRectMake(0, 20, totalW*number/318, 10);
    self.lineView.layer.cornerRadius = 5;
    self.lineView.layer.masksToBounds = YES;
    
            
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.lineView.bounds;
    // 渐变色颜色数组,可多个
    gradientLayer.colors = @[(__bridge id)RGB(101, 158, 224).CGColor,(__bridge id)RGB(50, 66, 143).CGColor];
//    gradientLayer.colors = [NSArray arrayWithObjects:(id)[RGB(101, 158, 224) CGColor], (id)[RGB(50, 66, 143) CGColor], nil];
    // 渐变的开始点 (不同的起始点可以实现不同位置的渐变,如图)
    gradientLayer.startPoint = CGPointMake(0, 0); //(0, 0)
    // 渐变的结束点
    gradientLayer.endPoint = CGPointMake(0, 1); //(1, 1)
    [self.lineView.layer insertSublayer:gradientLayer atIndex:0];
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor blueColor];
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 40, 12)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _titleLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-40, 0, 40, 12)];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.font = [UIFont systemFontOfSize:10];
    }
    return _numberLabel;
}





@end
