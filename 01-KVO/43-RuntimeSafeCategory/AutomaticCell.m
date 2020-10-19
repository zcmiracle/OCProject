//
//  AutomaticCell.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/12.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "AutomaticCell.h"

@interface AutomaticCell ()

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button1ConstantH;

@end

@implementation AutomaticCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTypeString:(NSString *)typeString {
    if ([typeString isEqualToString:@"0"]) {
        self.button1ConstantH.constant = 100;
    } else {
        self.button1ConstantH.constant = 50;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
