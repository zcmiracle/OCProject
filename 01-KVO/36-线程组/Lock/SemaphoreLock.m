//
//  SemaphoreLock.m
//  36-线程组
//
//  Created by XFB on 2020/4/7.
//  Copyright © 2020 XFB. All rights reserved.
//  信号量锁

#import "SemaphoreLock.h"

@interface SemaphoreLock () {
    // 信号量
    dispatch_semaphore_t _semaphore;
    // 锁
    NSLock *_lock;
    // 技数
    int _count;
}

@end

@implementation SemaphoreLock

- (instancetype)init {
    self = [super init];
    if (self) {
        // 初始化
        _lock = [[NSLock alloc] init];
        _semaphore = dispatch_semaphore_create(0);
        // 内存空间
        _count = 0;
    }
    return self;
}

// 信号量锁
- (void)signalLock {
    [NSThread detachNewThreadSelector:@selector(signalLockLoad) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(signalLockRead) toTarget:self withObject:nil];
}

- (void)signalLockLoad {
    while (1) {
        // 加锁
        [_lock lock];
        NSLog(@"signalLockLoad lock");

        if (_count >= 10) {
            NSLog(@"空间满了，等待中---%d", _count);
            // 等待信号
            dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        }
        
        _count ++;
        
        // 解锁
        [_lock unlock];
        NSLog(@"signalLockLoad unlock");
    }
}

- (void)signalLockRead {
    
    while (1) {
        NSLog(@"signalLockRead lock");
        [_lock lock];
        
        if (_count > 10) {
            _count --;
            NSLog(@"释放空间");
            dispatch_semaphore_signal(_semaphore);
        } else {
            _count ++;
        }
        
        NSLog(@"signalLockRead lock");
        [_lock unlock];
    }
    
}


@end
