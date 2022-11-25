//
//  NSObject+Category.m
//  21-self+super
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

@implementation NSObject (Category)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod(self, @selector(class));
        Method m2 = class_getInstanceMethod(self, @selector(myClass));
        method_exchangeImplementations(m1, m2);
    });
}

- (void)myClass {
    // self ---- <Son: 0x100603790>
//    NSLog(@"self ---- %@", self);
    [self myClass];
}

@end
