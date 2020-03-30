//
//  PermenantThread.h
//  26-线程保活
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//  常驻线程

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PermenantThreadTask)(void);

@interface PermenantThread : NSObject

// 开启一个常驻线程
- (void)run;

// 执行一个任务
- (void)executeTaskWithBlock:(PermenantThreadTask)task;

// 结束一个任务
- (void)stop;

@end

NS_ASSUME_NONNULL_END
