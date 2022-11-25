//
//  AmountLabel.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/10/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "AmountLabel.h"

#define kRangeNumberKey @"RangeKey"         //每次数字跳动相差的间隔数
#define kBeginNumberKey @"BeginNumberKey"   //起始数字
#define kEndNumberKey @"EndNumberKey"       //结束跳动时的数字
#define kFormatKey @"FormatStringKey"       //字符串格式

#define kFrequency 1.0/30.0f                //数字跳动频率
#define kRangeNumber(endNumber,duration) (endNumber * kFrequency)/duration

@interface AmountLabel ()

@property (nonatomic, strong) NSNumber *flickerNumber;
@property (nonatomic, copy) NSString *valueString;
@property (nonatomic, copy) NSString *formatStr;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *dict;

@end

@implementation AmountLabel

- (void)setNumber:(NSNumber *)number duration:(NSTimeInterval)duration format:(NSString *)formatStr {
    if (self.timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    self.formatStr = formatStr;
    
    //变量初始化
    double beginNumber = -40;
    double endNumber = [number doubleValue];
    
    _dict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [_dict setObject:@(beginNumber) forKey:kBeginNumberKey];
    [_dict setObject:number forKey:kEndNumberKey];
    [_dict setObject:@(kRangeNumber(endNumber, duration)) forKey:kRangeNumberKey];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),kFrequency*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self changeAnimation];
        });
    });
    dispatch_resume(_timer);
}


#pragma mark - private methods
- (void)changeAnimation {
    
    //获取字典信息
    double begin = ((NSNumber *)[_dict objectForKey:kBeginNumberKey]).doubleValue;
    double end = ((NSNumber *)[_dict objectForKey:kEndNumberKey]).doubleValue;
    double range = ((NSNumber *)[_dict objectForKey:kRangeNumberKey]).doubleValue;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    [formatter setPositiveFormat:self.formatStr];
    
    //获取text值 如果为0表示第一次；如果大于end表示到达最大值，结束定时器；否则显示当前数加上间隔数
    double value = self.valueString.doubleValue;
    if (value == 0) {
        self.valueString = [NSString stringWithFormat:@"%f", begin];
        self.text = [NSString stringWithFormat:@"%.@", [formatter stringFromNumber:@(begin)]];
    } else if (value >= end) {
        self.text = [NSString stringWithFormat:@"%.@", [formatter stringFromNumber:@(end)]];
        self.valueString = [NSString stringWithFormat:@"%f", begin];
        dispatch_source_cancel(_timer);
        _timer = nil;
        return;
    } else {
        value += range;
        self.valueString = [NSString stringWithFormat:@"%f", value];
        self.text = [NSString stringWithFormat:@"%.@", [formatter stringFromNumber:@(value)]];
    }
}

- (void)dealloc {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    NSLog(@"=========");
}
@end
