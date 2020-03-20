//
//  main.m
//  01-KVO
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

/**
KVO核心：当有一个类有观察者时，生成一个中间类，把它的isa指向中间类

原理：
# 当一个object有观察者时，动态创建这个object的类的子类
# 对于每个被观察的property，重写其set方法
# 在重写的setter方法中调用
   # - willChangeValueForKey
   # - didChangeValueForKey
查看类的变化状态
1、方法列表、属性列表、变量列表
2、类名class、isa object_getClass
3、Setter方法的imp、Class方法的imp
*/

#import <Foundation/Foundation.h>
#import "Person.h"
#import "RuntimeKit.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc] init];
        
        NSLog(@"变化之前-------------------------------------------");

        // 1、方法列表
        NSArray *methodArray1 = [RuntimeKit fetchMethodList:object_getClass(person)];
        NSLog(@"方法列表-methodArray1：%@", methodArray1);
        // 2、属性列表
        NSArray *propertyArray1 = [RuntimeKit fetchPropertyList:object_getClass(person)];
        NSLog(@"属性列表-propertyArray1：%@", propertyArray1);
        // 3、成员变量列表
        NSArray *ivarArray1 = [RuntimeKit fetchIvarList:object_getClass(person)];
        NSLog(@"成员变量列表-ivarArray1：%@", ivarArray1);
        // 4、类名
        Class className1 = [person class];
        NSLog(@"类名-className1：%@", className1);
        // 5、isa
        Class isaName1 = object_getClass(person);
        NSLog(@"isaName1：%@", isaName1);
        // 6、Setter方法的IMP
        IMP setterIMP1 = [person methodForSelector:@selector(setName:)];
        NSLog(@"setterIMP1：%p", setterIMP1);
        // 7、class方法的IMP
        IMP classIMP1 = [person methodForSelector:@selector(class)];
        NSLog(@"classIMP1：%p", classIMP1);
        
        [person addObserver:person forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

        NSLog(@"变化之后-------------------------------------------");
        // 1、方法列表
        NSArray *methodArray2 = [RuntimeKit fetchMethodList:object_getClass(person)];
        NSLog(@"方法列表-methodArray2：%@", methodArray2);
        // 2、属性列表
        NSArray *propertyArray2 = [RuntimeKit fetchPropertyList:object_getClass(person)];
        NSLog(@"属性列表-propertyArray2：%@", propertyArray2);
        // 3、成员变量列表
        NSArray *ivarArray2 = [RuntimeKit fetchIvarList:object_getClass(person)];
        NSLog(@"成员变量列表-ivarArray2：%@", ivarArray2);
        // 4、类名
        Class className2 = [person class];
        NSLog(@"类名-className2：%@", className2);
        // 5、isa
        Class isaName2 = object_getClass(person);
        NSLog(@"isaName2：%@", isaName2);
        // 6、Setter方法的IMP
        IMP setterIMP2 = [person methodForSelector:@selector(setName:)];
        NSLog(@"setterIMP2：%p", setterIMP2);
        // 7、class方法的IMP
        IMP classIMP2 = [person methodForSelector:@selector(class)];
        NSLog(@"classIMP1：%p", classIMP2);
        
        [person removeObserver:person forKeyPath:@"name"];
        
        NSLog(@"还原-------------------------------------------");

        // 1、方法列表
        NSArray *methodArray3 = [RuntimeKit fetchMethodList:object_getClass(person)];
        NSLog(@"方法列表-methodArray3：%@", methodArray3);
        // 2、属性列表
        NSArray *propertyArray3 = [RuntimeKit fetchPropertyList:object_getClass(person)];
        NSLog(@"属性列表-propertyArray3：%@", propertyArray3);
        // 3、成员变量列表
        NSArray *ivarArray3 = [RuntimeKit fetchIvarList:object_getClass(person)];
        NSLog(@"成员变量列表-ivarArray3：%@", ivarArray3);
        // 4、类名
        Class className3 = [person class];
        NSLog(@"类名-className3：%@", className3);
        // 5、isa
        Class isaName3 = object_getClass(person);
        NSLog(@"isaName3：%@", isaName3);
        // 6、Setter方法的IMP
        IMP setterIMP3 = [person methodForSelector:@selector(setName:)];
        NSLog(@"setterIMP3：%p", setterIMP3);
        // 7、class方法的IMP
        IMP classIMP3 = [person methodForSelector:@selector(class)];
        NSLog(@"classIMP3：%p", classIMP3);
        
    }
    return 0;
}
