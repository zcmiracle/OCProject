//
//  GCDTimer.m
//  03-定时器循环引用
//
//  Created by XFB on 2020/3/3.
//  Copyright © 2020 Fearless. All rights reserved.
//

#import "GCDTimer.h"

static NSMutableDictionary *timers_;
dispatch_semaphore_t semaphore_;

@implementation GCDTimer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}

+ (NSString *)execTask:(void(^)(void))task
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async {
    
    if (!task || start < 0 || (interval <= 0 && repeats)) return nil;
    // 队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置时间
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, start *NSEC_PER_SEC);
    uint64_t intervals = interval * NSEC_PER_SEC;
    uint64_t leeway = 0;
    dispatch_source_set_timer(timer, startTime, intervals, leeway);
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);

    // 定时器唯一标识
    NSString *name = [NSString stringWithFormat:@"%zd", timers_.count];
    
    // 存放到字典中
    timers_[name] = timer;
    dispatch_semaphore_signal(semaphore_);
    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    
    // 启动定时器
    dispatch_resume(timer);
    return name;
}

+ (void)cancelTask:(NSString *)name {
    
    if (name.length == 0) return;
   
    // +1信号
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t timer = timers_[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [timers_ removeObjectForKey:name];
    }
    
    // -1信号
    dispatch_semaphore_signal(semaphore_);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
