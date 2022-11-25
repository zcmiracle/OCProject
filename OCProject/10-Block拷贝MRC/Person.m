//
//  Person.m
//  10-Block拷贝MRC
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)method {
    __unsafe_unretained typeof(self) weakSelf = self;
    self.testBlock = ^{
        NSLog(@"%@", weakSelf.name);
    };
    self.testBlock();
}

- (void)setName:(NSString *)name {
    if (_name != name) {
        [_name release];
        _name = [name copy];
    }
}

- (void)dealloc {
    [super dealloc];
    NSLog(@"%s", __func__);
}

@end
