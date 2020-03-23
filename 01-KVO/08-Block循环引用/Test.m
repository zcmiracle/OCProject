//
//  Test.m
//  08-Block循环引用
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Test.h"

@implementation Test

- (void)weakMethod {
    
    // 解除循环引用 weak方式
    __weak typeof (self) weakSelf = self;
    self.testBlock = ^{
        NSLog(@"%@", weakSelf.name);
    };
    self.testBlock();
}

- (void)blockMethod {
    
    // 解除循环引用1 __block方式 要将对象置nil
    __block Test *blockTest = self;
    self.testBlock = ^{
        blockTest.name = @"Miracle";
        NSLog(@"%@", blockTest.name);
        blockTest = nil;
    };
    self.testBlock();
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
