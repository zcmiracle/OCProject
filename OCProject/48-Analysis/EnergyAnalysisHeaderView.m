//
//  EnergyAnalysisHeaderView.m
//  48-Analysis
//
//  Created by Fearless on 2020/10/28.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "EnergyAnalysisHeaderView.h"

@interface EnergyAnalysisHeaderView ()

// 426kW.h
@property (weak, nonatomic) IBOutlet UILabel *powerConsumptionLabel;
// 106t
@property (weak, nonatomic) IBOutlet UILabel *waterConsumptionLabel;

@end

@implementation EnergyAnalysisHeaderView

+ (instancetype)energyAnalysisHeaderView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 426kW.h
    NSString *string1 = @"426";
    string1 = [NSString stringWithFormat:@"%@kW.h", string1];
    self.powerConsumptionLabel.attributedText = [self setAttrStringWithString:string1 changeString:@"kW.h"];
    
    // 106t
    NSString *string2 = @"106";
    string2 = [NSString stringWithFormat:@"%@t", string2];
    self.waterConsumptionLabel.attributedText = [self setAttrStringWithString:string2 changeString:@"t"];
}

// 富文本渲染（可新建分类）
- (NSAttributedString *)setAttrStringWithString:(NSString *)totalString changeString:(NSString *)changeString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSDictionary *attributedDict = @{ NSFontAttributeName: [UIFont systemFontOfSize:12] };
    [attributedString setAttributes:attributedDict range:NSMakeRange(totalString.length - changeString.length, changeString.length)];
    return attributedString;
}

@end
