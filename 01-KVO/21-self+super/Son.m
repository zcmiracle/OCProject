//
//  Son.m
//  21-self+super
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Son.h"

@implementation Son

- (void)run {
    [super run];
}

#if 0

- (void)run {
    // super调用的receiver仍然是self = Son对象
    [super run];
}

static void _I_Son_run(Son * self, SEL _cmd) {
    // 原始版本
    ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("Son"))}, sel_registerName("run"));

    // 简化版本
    struct __rw_objc_super arg = {
        self,
        // 获取类对象的父类
        class_getSuperclass(objc_getClass("Son"))
        // [Father class]
    };
    
    struct objc_super arg = { self, [Father class] };
    objc_msgSendSuper(arg, @selector(run));
}

struct objc_super {
    __unsafe_unretained _Nonnull id receiver; // 消息接收者
    __unsafe_unretained _Nonnull Class super_class; // 消息接收者的父类
};


#endif



- (instancetype)init {
    self = [super init];
    if (self) {
//        // 1、沿着继承链找到方法，执行方法
//        NSLog(@"%@", NSStringFromClass([self class]));
//        // 2、执行[super class]方法时，消息接受者到底是？？？
//        NSLog(@"%@", NSStringFromClass([super class]));

        // xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc Son.m
        
        // 方法调用这 = 消息接收着
        // objc_msgSend(self, @selector(class))
        NSLog(@"[self class] = %@", [self class]);  // Son
        
        // objc_msgSuperSend({self, [Father class]}, @selector(class));
        // {self, [Father class]} self 是消息接收者  [Father class] 从父类方法列表查找方法
        
        
        // [super class] 底层实现：1、消息接收这仍然是子类对象 2、从父类开始查找方法的实现
        NSLog(@"[super class] = %@", [super class]); // Son  从父类查找方法
        NSLog(@"[self superclass] = %@", [self superclass]); // Father
        NSLog(@"[super superclass] = %@", [super superclass]); // Father

    }
    return self;
}

#if 0

- (Class)class {
    return object_getClass(self);
}

Class class_getSuperclass(Class cls) {
    if (!cls) return nil;
    return cls->superclass;
}


#endif


@end
