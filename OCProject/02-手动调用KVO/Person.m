//
//  Person.m
//  02-手动调用KVO
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Person.h"

@implementation Person

// 手动实现
- (void)setName:(NSString *)name {
    if (_name != name) {
        [self willChangeValueForKey:@"name"];
        _name = name;
        [self didChangeValueForKey:@"name"];
    }
}

- (void)setPersonInfo:(NSDictionary *)personInfo {
    [self willChangeValueForKey:@"name"];
    [self willChangeValueForKey:@"age"];
    _name = personInfo[@"name"];
    _age = personInfo[@"age"];
    [self didChangeValueForKey:@"name"];
    [self didChangeValueForKey:@"age"];
}

// 禁止
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"age"] ||
        [key isEqualToString:@"name"]) {
        return NO;
    } else {
        return [super automaticallyNotifiesObserversForKey:key];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"属性%@改变之前的值为：%@", keyPath, change[NSKeyValueChangeOldKey]);
    NSLog(@"属性%@改变之后的值为：%@", keyPath, change[NSKeyValueChangeNewKey]);
}

@end
