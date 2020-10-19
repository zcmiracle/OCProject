//
//  ViewController2.m
//  27-定时器
//
//  Created by Fearless on 2020/3/28.
//  Copyright © 2020 XFB. All rights reserved.
//  定时器

#import "ViewController2.h"
#import "WeakTimerObject.h"
#import "WeakTimerProxy.h"
#import "GCDTimer.h"

@interface ViewController2 ()

/** timerWithTimeInterval 方式创建定时器 */
@property (nonatomic, strong) NSTimer *timer1;
/** scheduledTimerWithTimeInterval 方式创建定时器 */
@property (nonatomic, strong) NSTimer *timer2;
/** 引入第三者 创建的定时器避免循环引用 */
@property (nonatomic, strong) NSTimer *timer3;
/** GCD定时器任务 */
@property (nonatomic, strong) NSString *gcdTimerTask;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 没有添加到runloop中方式
- (IBAction)startTimer1:(id)sender {
    self.timer1 = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"定时器timer1 ---");
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSDefaultRunLoopMode];
    [self.timer1 fire];
}

- (IBAction)startTimer2:(id)sender {
    // 此方式会造成循环引用，需引入第三者对象
    // 造成循环引用
//    self.timer2 = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    // 方式1：第三者继承自NSObject
    self.timer2 = [NSTimer timerWithTimeInterval:1.0 target:[WeakTimerObject zcWeakTimerObjectWithTarget:self] selector:@selector(updateTimer) userInfo:nil repeats:YES];
    // 方式2：第三者继承自NSProxy
//    self.timer2 = [NSTimer timerWithTimeInterval:1.0 target:[WeakTimerProxy zcWeakTimerProxyWithTarget:self] selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer2 forMode:NSDefaultRunLoopMode];
    [self.timer2 fire];
}

// 默认添加到当前线程runloop中
- (IBAction)startTimer3:(id)sender {
    self.timer3 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"定时器timer3 ---");
    }];
    [self.timer3 fire];
}

- (IBAction)startTimer4:(id)sender {
    self.gcdTimerTask = [GCDTimer execTask:^{
//        NSLog(@"GCD定时器 --- ");
        NSLog(@"------%@", [NSThread currentThread]);
    } start:0.0 interval:1.0 repeats:YES async:YES];
    
    [GCDTimer execTask:^{
//        NSLog(@"GCD定时器 --- ");
        NSLog(@"000000%@", [NSThread currentThread]);
    } start:0.0 interval:1.0 repeats:YES async:YES];
    
}

- (void)updateTimer {
    NSLog(@"定时器timer2 ---");
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self.timer1 invalidate];
    [self.timer2 invalidate];
    [self.timer3 invalidate];
    // 取消GCD定时器
    [GCDTimer cancelTask:self.gcdTimerTask];
}

@end
