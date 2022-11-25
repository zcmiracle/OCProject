//
//  main.m
//  02-手动调用KVO
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Person *person = [[Person alloc] init];
        person.name = @"LBJ";
        
        // 添加Observer
        [person addObserver:person forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [person addObserver:person forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

        person.name = @"Fearless";
        
        // 手动发送通知
//        [person willChangeValueForKey:@"name"];
//        person.name = @"Miracle";
//        [person didChangeValueForKey:@"name"];
        
        // 调用重写的setter方法
//        person.name = @"James";

        // 发送两个通知
//        [person setPersonInfo:@{@"name" : @"Tom", @"age" : @"20"}];

    }
    return 0;
}
