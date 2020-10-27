//
//  CourseHeatViewHalfView.m
//  46-ProductCapacity
//
//  Created by Fearless on 2020/10/27.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "CourseHeatViewHalfView.h"
#import "HorizontalBarView.h"

@implementation CourseHeatViewHalfView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    
    // 首先删除子控件
    for (int i = 0; i < dataArray.count; i ++) {
        HorizontalBarView *sectionView = [[HorizontalBarView alloc] initWithFrame:CGRectMake(20, 45*i, ScreenWidth/2-30, 45)];
//        sectionView.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
        sectionView.dataDict = dataArray[i];
        [self addSubview:sectionView];
    }
    
}

@end
