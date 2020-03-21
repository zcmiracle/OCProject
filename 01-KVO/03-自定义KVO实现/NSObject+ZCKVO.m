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
               options:(ZCKeyValueObservingOptions)options {
    
    // 1、获取setter方法名
    NSString *setterName = [NSString stringWithFormat:@"set%@", [keyPath capitalizedString]];

    SEL setterSEL = NSSelectorFromString(setterName);
    
    // 2、获取对应的setter方法
    Method setterMethod = class_getInstanceMethod([self class], setterSEL);
    
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
    ZCObserverInfo *observerInfo = [[ZCObserverInfo alloc] initWithObserver:observer Key:keyPath options:options];
    NSMutableArray *observerArr = objc_getAssociatedObject(self, &KVO_ObserverArray);
    if (!observerArr) {
        observerArr = [NSMutableArray array];
    }
    [observerArr addObject:observerInfo];
    // 设置关联对象
    objc_setAssociatedObject(self, &KVO_ObserverArray, observerArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

void KVO_setter(id self, SEL _cmd, id newValue) {
    // 1、获取key setName: --- set Name
    NSString *setterString = NSStringFromSelector(_cmd);
    // key的首字母小写：n
    NSString *string = [[setterString substringWithRange:NSMakeRange(3, 1)] lowercaseString];
    // 获取key的剩余字母 ame
    NSString *string2 = [setterString substringWithRange:NSMakeRange(4, [setterString rangeOfString:@":"].location - 4)];
    NSString *key = [NSString stringWithFormat:@"%@%@", string, string2];
    
    // 2、获取以前的value值
    id oldValue = [self valueForKey:key];
    
    // 3、调用父类的setter方法
    struct objc_super superClass;
    superClass.receiver = self;
    superClass.super_class = class_getSuperclass(object_getClass(self));
    ((void (*)(void *, SEL, id))(void *)objc_msgSendSuper)(&superClass, _cmd, newValue);
    // 4、通知外界
    NSMutableArray *observers = objc_getAssociatedObject(self, &KVO_ObserverArray);
    for (ZCObserverInfo *observerInfo in observers) {
        if ([observerInfo.key isEqualToString:key]) {
            // 5、封装回传消息
            // ZCKeyValueObservingOptionsNew | ZCKeyValueObservingOptionsOld = 11
            // observerInfo.option & ZCKeyValueObservingOptionsNew = 11&01 = 01
            // observerInfo.options & ZCKeyValueObservingOptionsOld = 11&10 = 10
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                NSMutableDictionary<NSKeyValueChangeKey, id> *change = [NSMutableDictionary dictionaryWithCapacity:2];
                
                if (observerInfo.options & ZCKeyValueObservingOptionsNew) {
                    [change setObject:newValue forKey:NSKeyValueChangeNewKey];
                }
                
                if (observerInfo.options & ZCKeyValueObservingOptionsOld) {
                    [change setObject:oldValue forKey:NSKeyValueChangeOldKey];
                }
                
                ((void (*)(id, SEL, id, id, id))(void *)objc_msgSend)(observerInfo.observer, @selector(zc_observeValueForKeyPath:ofObject:change:), observerInfo.key, self, change);

            });
        }
    }
}

Class KVO_class(id self, SEL _cmd) {
    // 获取isa、再获取isa的父类
    return class_getSuperclass(object_getClass(self));
}

// 监听KVO
- (void)zc_observeValueForKeyPath:(NSString *)keyPath
                         ofObject:(id)object
                           change:(NSDictionary<NSKeyValueChangeKey,id> *)change {
    NSLog(@"%@", change);
}

// 删除KVO
- (void)zc_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    NSMutableArray *observers = objc_getAssociatedObject(self, &KVO_ObserverArray);
    if (!observers || observers.count <= 0) {
        return;
    }
    
    for (ZCObserverInfo *observerInfo in observers) {
        if ([observerInfo.key isEqualToString:keyPath]) {
            [observers removeObject:observerInfo];
            objc_setAssociatedObject(self, &KVO_ObserverArray, observers, OBJC_ASSOCIATION_RETAIN);
            return;
        }
    }
    
    // 当observers为空时，重新设置isa
    if (observers.count <= 0) {
        object_setClass(self, [self class]);
    }
}

@end
