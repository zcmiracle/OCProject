//
//  ORRingChartConfig.m
//  ORChartView
//
//  Created by OrangesAL on 2019/6/1.
//  Copyright © 2019 OrangesAL. All rights reserved.
//

#import "ORRingChartConfig.h"

@implementation ORRingChartConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _clockwise = YES;
        _neatInfoLine = NO;

        _startAngle = M_PI * 2 / 3;
        // 围绕线宽度
        _ringLineWidth = 1;
        _infoLineWidth = 0;

        _minInfoInset = -30;
        _infoLineMargin = 10;
        _infoLineInMargin = 10;
        _infoLineBreakMargin = 15;
        _infoViewMargin = 4;
        _pointWidth = 5;
        
        _animateDuration = 1;
        _ringWidth = 60;        
        _animateDuration = 1;
        
       
    }
    return self;
}

@end
