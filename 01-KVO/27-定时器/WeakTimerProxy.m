//
//  WeakTimerProxy.m
//  27-定时器
//
//  Created by Fearless on 2020/3/28.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "WeakTimerProxy.h"

@implementation WeakTimerProxy

+ (instancetype)zcWeakTimerProxyWithTarget:(id)target {
    // NSProxy 没有init方法，直接alloc可以
    WeakTimerProxy *proxy = [WeakTimerProxy alloc];
    proxy.target = target;
    return proxy;
}

// 方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if (self.target) {
        return [self.target methodSignatureForSelector:sel];
    }
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

// 设置自己的target
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
