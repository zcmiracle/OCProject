//
//  Student.m
//  04-KVC赋值
//
//  Created by XFB on 2020/3/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Student.h"

@implementation Student

//- (void)setName:(NSString *)name {
//    NSLog(@"setName --- %@", name);
//}

//- (void)_setName:(NSString *)name {
//    NSLog(@"setName --- %@", name);
//}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey - %@", key);
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"didChangeValueForKey --- begian --- %@", key);
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey --- end --- %@", key);
}

// 直接访问成员变量 NO ---> 不允许返回成员变量，默认返回值为YES
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

@end
