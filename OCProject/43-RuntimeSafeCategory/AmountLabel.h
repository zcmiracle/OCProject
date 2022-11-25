//
//  AmountLabel.h
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/10/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AmountLabel : UILabel

- (void)setNumber:(NSNumber *)number duration:(NSTimeInterval)duration format:(NSString *)formatStr;

@end

NS_ASSUME_NONNULL_END
