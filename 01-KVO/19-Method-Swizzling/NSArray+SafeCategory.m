//
//  NSArray+SafeCategory.m
//  19-Method-Swizzling
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "NSArray+SafeCategory.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSArray (SafeCategory)

/**
 load中交换方法
 1、main函数之前调用
 2、自动执行，不需要手动执行
 3、唯一性，不用担心被子类覆盖掉
 */
+ (void)load {
    // 只交换一次，防止多次交换还原之前
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayI") swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(zc_objectAtIndex:)];
    });
}

- (id)zc_objectAtIndex:(NSUInteger)index {
    if (index > self.count - 1) {
        NSLog(@"数组越界");
        return nil;
    } else {
        return [self zc_objectAtIndex:index];
    }
}

@end
