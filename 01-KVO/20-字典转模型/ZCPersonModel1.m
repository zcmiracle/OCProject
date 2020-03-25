//
//  ZCPersonModel1.m
//  20-字典转模型
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ZCPersonModel1.h"

@implementation ZCPersonModel1

- (void)initWithDataDict:(NSDictionary *)data {
    self = [super initWithDataDict:data];
    if (self) {
        self.personId = data[@"id"];
    }
    return self;
}

@end
