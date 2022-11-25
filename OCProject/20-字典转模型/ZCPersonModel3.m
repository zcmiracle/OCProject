//
//  ZCPersonModel3.m
//  20-字典转模型
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ZCPersonModel3.h"

@implementation ZCPersonModel3

- (NSString *)modelClassInPropertyArray:(NSString *)name {
    if ([name isEqualToString:@"students"]) {
        return NSStringFromClass([ZCStudentModel class]);
    }
    return @"";
}


@end
