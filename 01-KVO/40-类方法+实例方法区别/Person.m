//
//  Person.m
//  40-类方法+实例方法区别
//
//  Created by XFB on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Person.h"

@implementation Person

// 实例方法
- (void)instanceMethod {
    // 断点 self = <Person: 0x100647d00>
    NSLog(@"Person instanceMethod!");
}

// 类方法
+ (void)classMethod {
    // 断点 self = Person
    NSLog(@"Person classMethod!");
}

@end
