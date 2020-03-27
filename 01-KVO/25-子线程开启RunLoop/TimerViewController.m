//
//  TimerViewController.m
//  25-子线程开启RunLoop
//
//  Created by XFB on 2020/3/27.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "TimerViewController.h"
#import "GCDTimer.h"

@interface TimerViewController ()

@property (nonatomic, strong) NSTimer *timer1;
@property (nonatomic, strong) NSTimer *timer2;
@property (nonatomic, strong) NSTimer *timer3;


@property (nonatomic, copy) NSString *timerTask;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testTimer1];
//    [self testTimer2];
//    [self testTimer3];

    // GCD定时器
    [self testTimer4];
}

- (void)testTimer1 {
    dispatch_queue_t queue = dispatch_queue_create("Timer1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        self.timer1 = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"定时器启动 %@", [NSThread currentThread]);
        }];
        [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)testTimer2 {
    dispatch_queue_t queue = dispatch_queue_create("Timer2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        // 开启子线程
        self.timer2 = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"定时器启动 %@", [NSThread currentThread] );
        }];
        //需要立即执行
        [self.timer2 fire];
        // 调用子线程runLoop
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)testTimer3 {
    dispatch_queue_t queue = dispatch_queue_create("Timer3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        // 开启子线程
        self.timer3 = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"定时器启动 %@", [NSThread currentThread]);
            static int num = 0;
            num ++;
            // 满足条件后，停止当前的运行循环
            if (num == 5) {
                // 停止当前的运行循环
                // 一旦停止了运行循环，后续代码能够执行，执行完毕后，线程被自动销毁
                CFRunLoopStop(CFRunLoopGetCurrent());
                num = 0;
            }
        }];
        // 需要立即执行
        [self.timer3 fire];
        [[NSRunLoop currentRunLoop] addTimer:self.timer3 forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] run];
        CFRunLoopRun();
    });
}

- (void)testTimer4 {
    self.timerTask = [GCDTimer execTask:^{
        NSLog(@"定时器启动 %@", [NSThread currentThread]);
    } start:0.0 interval:1.0 repeats:YES async:YES];
}

- (void)dealloc {
//    [self.timer1 invalidate];
//    [self.timer2 invalidate];
//    [self.timer3 invalidate];
  
    [GCDTimer cancelTask:self.timerTask];
    NSLog(@"%s", __func__);
}


@end
