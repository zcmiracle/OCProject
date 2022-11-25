//
//  ManpowerAnalysisHeaderView.m
//  48-Analysis
//
//  Created by XFB on 2020/10/22.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ManpowerAnalysisHeaderView.h"

@interface ManpowerAnalysisHeaderView ()

// 前日入职 0 蓝色
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
// 前日离职 0 白色
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
// 本月入职 0 蓝色
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
// 本月离职 0 白色
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;


@end

@implementation ManpowerAnalysisHeaderView

+ (instancetype)analysisHeaderView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

@end
