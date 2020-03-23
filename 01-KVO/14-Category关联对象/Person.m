//
//  Person.m
//  14-Category关联对象
//
//  Created by Fearless on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

// 关联对象 能够为分类添加属性
- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, @"name");
}

@end
