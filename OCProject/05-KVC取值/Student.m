//
//  Student.m
//  05-KVC取值
//
//  Created by XFB on 2020/3/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString *)getName {
    return @"getName";
}

- (NSString *)name {
    return @"name";
}

- (NSString *)isName {
    return @"isName";
}

- (NSString *)_name {
    return @"_name";
}



//- (void)setName:(NSString *)name {
//    NSLog(@"setName --- %@", name);
//}

//- (void)_setName:(NSString *)name {
//    NSLog(@"_setName --- %@", name);
//}

// 默认实现了这两个方法 调用这两个方法只是访问成员变量，如果没有实现setKey和_setKey的情况下
// 按照访问成员变量的顺序 _key _isKey key isKey
//- (void)willChangeValueForKey:(NSString *)key {
//    [super willChangeValueForKey:key];
//    NSLog(@"willChangeValueForKey - %@", key);
//}
//
//- (void)didChangeValueForKey:(NSString *)key {
//
//    NSLog(@"didChangeValueForKey - begain --- %@", key);
//
//    [super didChangeValueForKey:key];
//
//    NSLog(@"didChangeValueForKey - end --- %@", key);
//}

// 直接访问成员变量 NO--->不允许返回成员变量 ，默认返回值YES
// NO reason: '[<Person 0x1038a8020> setValue:forUndefinedKey:]
//+ (BOOL)accessInstanceVariablesDirectly {
//    return YES;
//}

@end
