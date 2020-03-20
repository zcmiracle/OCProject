//
//  main.m
//  03-自定义KVO实现
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RuntimeKit.h"
#import "Person.h"
#import "NSObject+ZCKVO.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc] init];
    
        NSLog(@"变化之前--------------------------------------");
        // 1.方法列表
        NSLog(@"methodArr：%@", [RuntimeKit fetchMethodList:object_getClass(person)]);
        // 2.class
        NSLog(@"class：%@", [person class]);
        // 3.isa
        NSLog(@"isa：%@", object_getClass(person));
        // 4.setter方法的imp
        NSLog(@"setterIMP：%p", [person methodForSelector:@selector(setName:)]);
        // 5.class方法的imp
        NSLog(@"classIMP：%p", [person methodForSelector:@selector(class)]);
        
        person.name = @"Fearless";
        [person zc_addObserver:person forKeyPath:@"name" options:ZCKeyValueObservingOptionsNew | ZCKeyValueObservingOptionsOld];
        person.name = @"Miracle";
        
        NSLog(@"变化之后--------------------------------------");
        // 1.方法列表
        NSLog(@"methodArr：%@", [RuntimeKit fetchMethodList:object_getClass(person)]);
        // 2.class
        NSLog(@"class：%@", [person class]);
        // 3.isa
        NSLog(@"isa：%@", object_getClass(person));
        // 4.setter方法的imp
        NSLog(@"setterIMP：%p", [person methodForSelector:@selector(setName:)]);
        // 5.class方法的imp
        NSLog(@"classIMP：%p", [person methodForSelector:@selector(class)]);
        
        [person zc_removeObserver:person forKeyPath:@"name"];
        
        NSLog(@"还原--------------------------------------");
        // 1.方法列表
          NSLog(@"methodArr：%@", [RuntimeKit fetchMethodList:object_getClass(person)]);
          // 2.class
          NSLog(@"class：%@", [person class]);
          // 3.isa
          NSLog(@"isa：%@", object_getClass(person));
          // 4.setter方法的imp
          NSLog(@"setterIMP：%p", [person methodForSelector:@selector(setName:)]);
          // 5.class方法的imp
          NSLog(@"classIMP：%p", [person methodForSelector:@selector(class)]);
    }
    return 0;
}


/**
 主要方法：
 添加通知：
 zc_addObserver...
 
 监听通知：
 zc_observerValueForKey
 
 删除通知：
 zc_removeObserver

 核心工作：
 1、修改isa
 2、添加修改后的setter方法
 3、添加修改后的class方法
 4、通知外界
 */
