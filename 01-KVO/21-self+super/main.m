//
//  main.m
//  21-self+super
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Son.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Son *son = [[Son alloc] init];
        
    }
    return 0;
}


#if 0

[self class];

// 返回当前对象
- (Class)class {
    return object_getClass(self);
}

Class object_getClass(id obj) {
    if (obj) return obj->getIsa();
    else return Nil;
}

// superclass
Class class_getSuperclass(Class cls) {
    if (!cls) return nil;
    return cls->superclass;
}

[super class];


struct objc_super objcSuper = {
    self,
    class_getSuperclass([self class]),
};
objc_msgSendSuper(&objcSuper, @selector(class));

id objc_msgSendSuper(struct objc_super *super, SEL op, ...)


struct objc_super {
    __unsafe_unretained _Nonnull id receiver; // 消息接收者
    __unsafe_unretained _Nonnull Class super_class; // 消息接收者的父类
};



+ (Class)class {
    return self;
}

- (Class)class {
    return object_getClass(self);
}

+ (Class)superclass {
    return self->superclass;
}

- (Class)superclass {
    return [self class]->superclass;
}


#endif
