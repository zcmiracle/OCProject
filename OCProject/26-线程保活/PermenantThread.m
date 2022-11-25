//
//  PermenantThread.m
//  26-线程保活
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//  常驻线程

#import "PermenantThread.h"
#import "ZCThread.h"

@interface PermenantThread ()

@property (nonatomic, strong) ZCThread *thread;
@property (nonatomic, assign, getter=isStopped) BOOL stopped;

@end

@implementation PermenantThread

- (instancetype)init {
    self = [super init];
    if (self) {
        self.stopped = NO;
        __weak typeof(self) weakSelf = self;
        self.thread = [[ZCThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.stopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
        [self.thread start];
    }
    return self;
}

// 执行任务
- (void)executeTaskWithBlock:(PermenantThreadTask)task {
    if (!self.thread || !task) {
        return;
    }
    [self performSelector:@selector(__executeTask:) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)stop {
    if (!self.thread) {
        return;
    }
    [self performSelector:@selector(__stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)__executeTask:(PermenantThreadTask)task {
    task();
}

- (void)__stop {
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self stop];
}

@end
