//
//  NSObject+Swizzled.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "NSObject+Swizzled.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzled)

/// 交换实例对象方法
/// @param originalSEL 原始方法SEL
/// @param swizzledSEL 类方法SEL
+ (BOOL)swizzleInstanceObjMethod:(SEL)originalSEL swizzledSEL:(SEL)swizzledSEL {
    
    // 获取originalSEL的method
    Method originalMehtod = class_getInstanceMethod(self, originalSEL);
    // 获取swizzledSEL的method
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSEL);
    
    if (!originalMehtod) {
        NSLog(@"original method：%@ no found", NSStringFromSelector(originalSEL));
    }
    if (!swizzledMethod) {
        NSLog(@"swizzled method：%@ no found", NSStringFromSelector(swizzledSEL));
    }
    
    // 交换方法前先添加方法的实现
    IMP originalIMP = class_getMethodImplementation(self, originalSEL);
    IMP swizzledIMP = class_getMethodImplementation(self, swizzledSEL);
    class_addMethod(self, originalSEL, originalIMP, method_getTypeEncoding(originalMehtod));
    class_addMethod(self, swizzledSEL, swizzledIMP, method_getTypeEncoding(swizzledMethod));

    // 交换方法实现
    method_exchangeImplementations(class_getInstanceMethod(self, originalSEL),
                                   class_getInstanceMethod(self, swizzledSEL));
    
    return YES;
}

@end
