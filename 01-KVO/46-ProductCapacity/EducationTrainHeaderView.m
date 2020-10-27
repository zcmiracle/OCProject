//
//  EducationTrainHeaderView.m
//  46-ProductCapacity
//
//  Created by Fearless on 2020/10/27.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "EducationTrainHeaderView.h"

@interface EducationTrainHeaderView ()

/// 75门
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
/// 626
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
/// 5323
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
/// 0人次
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;

///// 课程总数
//@property (weak, nonatomic) IBOutlet UILabel *firstSubTitleLabel;
///// 用户总数
//@property (weak, nonatomic) IBOutlet UILabel *secondSubTitleLabel;
///// 考试通过人次
//@property (weak, nonatomic) IBOutlet UILabel *thirdSubTitleLabel;
///// 系统登录数
//@property (weak, nonatomic) IBOutlet UILabel *fourthSubTitleLabel;

@end

@implementation EducationTrainHeaderView

+ (instancetype)headerView {
    EducationTrainHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    return headerView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
 
    // 75门
    NSString *string1 = @"0";
    string1 = [NSString stringWithFormat:@"%@门", string1];
    self.firstLabel.attributedText = [self setAttrStringWithString:string1 changeString:@"门"];

    // 626
    NSString *string2 = @"626";
    self.secondLabel.text = string2;
    
    // 5323
    NSString *string3 = @"5323";
    string3 = [self handleNumberString:string3];
    string3 = [NSString stringWithFormat:@"%@", string3];
    self.thirdLabel.text = string3;
    
    // 100%
    NSString *string4 = @"100";
    string4 = [self handleNumberString:string4];
    string4 = [NSString stringWithFormat:@"%@人次", string4];
    self.fourthLabel.attributedText = [self setAttrStringWithString:string4 changeString:@"人次"];
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
