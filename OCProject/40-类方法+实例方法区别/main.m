//
//  main.m
//  40-类方法+实例方法区别
//
//  Created by XFB on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc] init];
        
        /**
         一般情况下，类对象只可以调用类方法
         实例对象只可以调用实例方法
         */
//        [p performSelector:@selector(classMethod)];
//        [Person performSelector:@selector(instanceMethod)];
             
        
        // 实例方法调用
        [p instanceMethod];
        // 类方法调用
        [Person classMethod];
        
        ( (void(*)(id, SEL)) (void *)objc_msgSend )( (id)p, sel_registerName("instanceMethod") );
        ( (void(*)(id, SEL)) (void *)objc_msgSend )( objc_getClass("Person"), sel_registerName("classMethod") );
     
        
        // 验证： class_getMethodImplementation 从指定类方法列表中查找指定的方法，返回此方法的地址
        IMP instanceMethodIMP = class_getMethodImplementation([Person class], @selector(instanceMethod));
        Class metaClass = objc_getMetaClass(class_getName([Person class]));
        IMP classMethodIMP = class_getMethodImplementation(metaClass, @selector(classMethod));
        
        // 执行
        instanceMethodIMP();
        classMethodIMP();
        
        /**
         总结：
         一般情况下，类对象只可以调用类方法
         实例对象只可以调用实例方法
         
         实例方法里面的self，是对象的首地址
         类方法的self，是class
         
         类方法，在元类方法列表中
         实例方法，在对象方法列表中
         
         
         实例 --> 类 --> 元类
         获取isa，在isa对象的方法列表中查找指定方法
         传入实例对象，在类的方法列表中查找
         传入类对象，在元类的方法列表中查找
         
         */

    }
    return 0;
}
