//
//  ZCPerson.m
//  16-msgForward
//
//  Created by XFB on 2020/3/24.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ZCPerson.h"
#import "Dog.h"
#import <objc/runtime.h>

@implementation ZCPerson

- (void)run {
    NSLog(@"%s", __func__);
}

// 动态方法解析
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(run)) {
        class_addMethod([ZCPerson class], sel, (IMP)runIMP, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

void runIMP(id cls, SEL cmd) {
    NSLog(@"ZCPerson run");
}
 
// 直接走消息转发流程
// 重定向
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(run)) {
//        Dog *dog = [[Dog alloc] init];
//        return dog;
        return nil;
    }
    return [super forwardingTargetForSelector:aSelector];
}

// 方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(run)) {
        NSMethodSignature *method = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        return method;
    }
    return [super methodSignatureForSelector:aSelector];
}

// 方法实现
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if (anInvocation.selector == @selector(run)) {
        [anInvocation invokeWithTarget:[ZCPerson new]];
    }
    NSLog(@"123456");
}

@end
