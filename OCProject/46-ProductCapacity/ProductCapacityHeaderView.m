//
//  ProductCapacityHeaderView.m
//  ProductionCapacity
//
//  Created by Fearless on 2020/10/20.
//  Copyright © 2020 Fearless. All rights reserved.
//  产能分析HeaderView

#import "ProductCapacityHeaderView.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface ProductCapacityHeaderView ()

/// 0H
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
/// 116.39H
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
/// 3595000PCS
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
/// 100%
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;

/// 当前时段产出工时
@property (weak, nonatomic) IBOutlet UILabel *firstSubTitleLabel;
/// 当日产出工时
@property (weak, nonatomic) IBOutlet UILabel *secondSubTitleLabel;
/// 良品数(冲压产出)
@property (weak, nonatomic) IBOutlet UILabel *thirdSubTitleLabel;
/// 良率(冲压产出)
@property (weak, nonatomic) IBOutlet UILabel *fourthSubTitleLabel;

@end

@implementation ProductCapacityHeaderView

+ (instancetype)headerViewWithSubTitle1:(NSString *)subTitle1 subTitle2:(NSString *)subTitle2 {
    ProductCapacityHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    headerView.thirdSubTitleLabel.text = subTitle1;
    headerView.fourthSubTitleLabel.text = subTitle2;
    return headerView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
 
    // 0H
    NSString *string1 = @"0";
    string1 = [NSString stringWithFormat:@"%@H", string1];
    self.firstLabel.attributedText = [self setAttrStringWithString:string1 changeString:@"H"];

    // 116.39H
    NSString *string2 = @"116.39";
    string2 = [NSString stringWithFormat:@"%@H", string2];
    self.secondLabel.attributedText = [self setAttrStringWithString:string2 changeString:@"H"];

    // 3595000 PCS
    NSString *string3 = @"3595000";
    string3 = [self handleNumberString:string3];
    string3 = [NSString stringWithFormat:@"%@ PCS", string3];
    self.thirdLabel.attributedText = [self setAttrStringWithString:string3 changeString:@"PCS"];
    
    // 100%
    NSString *string4 = @"100";
    string4 = [self handleNumberString:string4];
    string4 = [NSString stringWithFormat:@"%@%%", string4];
    self.fourthLabel.attributedText = [self setAttrStringWithString:string4 changeString:@"%"];
}

// 富文本渲染（可新建分类）
- (NSAttributedString *)setAttrStringWithString:(NSString *)totalString changeString:(NSString *)changeString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSDictionary *attributedDict = @{ NSFontAttributeName: [UIFont systemFontOfSize:12] };
    [attributedString setAttributes:attributedDict range:NSMakeRange(totalString.length - changeString.length, changeString.length)];
    return attributedString;
}

// 数字 +（逗号，）
- (NSString *)handleNumberString:(NSString *)numberString {
    NSString *str = [numberString substringWithRange:NSMakeRange(numberString.length%3, numberString.length - numberString.length%3)];
    NSString *strings = [numberString substringWithRange:NSMakeRange(0, numberString.length%3)];
    for (int i = 0; i < str.length; i = i + 3) {
        NSString *charString = [str substringWithRange:NSMakeRange(i, 3)];
        strings = [strings stringByAppendingString:[NSString stringWithFormat:@",%@", charString]];
    }
    if ([[strings substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
        strings = [strings substringWithRange:NSMakeRange(1, strings.length - 1)];
    }
    return strings;
}

@end
