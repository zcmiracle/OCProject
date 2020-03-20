//
//  NSObject+ZCKVO.m
//  03-自定义KVO实现
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "NSObject+ZCKVO.h"
#import <objc/runtime.h> // 类相关函数
#import <objc/message.h> // 消息相关函数
#import "ZCObserverInfo.h"

static const char KVO_ObserverArray;

// 自定义KVO前缀
static NSString *ZCKVONotifying_ = @"ZCKVONotifying_";

@implementation NSObject (ZCKVO)

/**
 1、注册类，继承self
 2、修改isa
 3、重写setter方法
 4、重写class方法
 5、通知外界
 */
- (void)zc_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options {
    
    // 1、获取setter方法名
    NSString *setterName = [NSString stringWithFormat:@"set%@", [keyPath capitalizedString]];
    SEL setterSEL = NSSelectorFromString(setterName);
    
    // 2、获取对应的setter方法
    Method setterMethod = class_getInstanceMethod([self class], setterSEL)
    
    if (setterMethod) {
        NSLog(@"指定的key，不存在或者没有setter方法");
        return;
    }
    
    // 3、判断是否已经替换过isa
    Class isaClass = object_getClass(self);
    NSString *isaName = NSStringFromClass(isaClass);
    if (![isaName hasPrefix:ZCKVONotifying_]) {
        // 4、注册新类
        NSString *oldClassName = NSStringFromClass([self class]);
        NSString *isaClassName = [ZCKVONotifying_ stringByAppendingString:oldClassName];
        isaClass = NSClassFromString(isaClassName);// 能拿到说明类已经注册了，不需要注册
        if (!isaClass) {
            // 创建新类
            isaClass = objc_allocateClassPair([self class], [isaClassName UTF8String], 0);
            // 注册新类
            objc_registerClassPair(isaClass);
        }
        
        // 5、修改原类的isa
        object_setClass(self, isaClass);
    }
    
    // 6、添加setter方法
    // 此时[self class] = ZCKVONotifying_xxx，或者用isaClass
    class_addMethod([self class],
                    setterSEL,
                    (IMP)KVO_setter,
                    method_getTypeEncoding(setterMethod));
    
    // 7、添加Class方法
    SEL classSEL = @selector(class);
    Method classMethod = class_getInstanceMethod([self class], classSEL);
    class_addMethod([self class], classSEL, (IMP)KVO_class, method_getTypeEncoding(classMethod));
    
    // 8、处理观察者
    // 将信息添加到ZCObserverInfo中然后添加到KVO_ObserverArray中
     
    
}

void KVO_setter(id self, SEL _cmd, id newValue) {
    
}

void KVO_class(id self, SEL _cmd, id newValue) {
    
}

// 监听KVO
- (void)zc_observeValueForKeyPath:(NSString *)keyPath
                         ofObject:(id)object
                           change:(NSDictionary<NSKeyValueChangeKey,id> *)change {
    
}

// 删除KVO
- (void)removeObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath {
    
}

@end
