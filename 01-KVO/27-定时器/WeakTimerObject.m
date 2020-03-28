//
//  WeakTimerObject.m
//  27-定时器
//
//  Created by Fearless on 2020/3/28.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "WeakTimerObject.h"

@implementation WeakTimerObject

+ (instancetype)zcWeakTimerObjectWithTarget:(id)target {
    WeakTimerObject *timerObject = [[WeakTimerObject alloc] init];
    timerObject.target = target;
    return timerObject;
}

// 继承自NSObject的话，会走消息发送流程，并且会动态方法解析
// 动态方法解析
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return YES;
//}

// 重定向
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (self.target) {
        return self.target;
    } else {
        return nil;
    }
}

// 方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (self.target) {
        return [self.target methodSignatureForSelector:aSelector];
    } else {
        // 防止闪退奔溃
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.target];
}

@end
