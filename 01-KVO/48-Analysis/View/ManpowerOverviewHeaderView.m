//
//  ManpowerOverviewHeaderView.m
//  48-Analysis
//
//  Created by XFB on 2020/10/22.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ManpowerOverviewHeaderView.h"

@interface ManpowerOverviewHeaderView ()

/// 人员总数
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
/// 应出勤数
@property (weak, nonatomic) IBOutlet UILabel *requireCountLabel;
/// 实出勤数
@property (weak, nonatomic) IBOutlet UILabel *actualCountLabel;

@end

@implementation ManpowerOverviewHeaderView

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}


@end
