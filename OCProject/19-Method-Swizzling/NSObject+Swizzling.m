//
//  NSObject+Swizzling.m
//  19-Method-Swizzling
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)swizzleMethod:(SEL)originalSEL withMethod:(SEL)swizzledSEL {
    // 1、获取originSEL、swizzleSEL的method
    Method originMethod = class_getInstanceMethod(self, originalSEL);
    if (!originMethod) {
        NSLog(@"origin method：%@ no found", NSStringFromSelector(originalSEL));
        return;
    }
    
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSEL);
    if (!swizzledMethod) {
        NSLog(@"swizzle method：%@ no found", NSStringFromSelector(swizzledSEL));
        return;
    }
    
    // 给子类添加方法实现。子类如果实现了，会添加失败，这样还是交换子类的方法，
    // 如果子类没有方法实现，会添加成功，还是交换子类的方法
    // 2、为了避免影响到父类的方法，添加方法的实现
    IMP originalIMP = class_getMethodImplementation(self, originalSEL);
    class_addMethod(self, originalSEL, originalIMP, method_getTypeEncoding(originMethod));
    
    IMP swizzledIMP = class_getMethodImplementation(self, swizzledSEL);
    class_addMethod(self, swizzledSEL, swizzledIMP, method_getTypeEncoding(swizzledMethod  ));

    // 3、交换方法实现
    // 这里最好重新获取下 class_getInstanceMethod 因为originMethod和swizzledMethod可能是父类的
    method_exchangeImplementations(class_getInstanceMethod(self, originalSEL),
                                   class_getInstanceMethod(self, swizzledSEL));
    
}

@end
