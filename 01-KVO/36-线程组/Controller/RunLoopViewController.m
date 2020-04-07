
//
//  RunLoopViewController.m
//  36-线程组
//
//  Created by XFB on 2020/4/7.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RunLoop";

    // 添加RunLoop监听
    [self addRunLoopObserver];
    // 创建线程
    [NSThread detachNewThreadSelector:@selector(createThread) toTarget:self withObject:nil];
}

- (void)createThread {
    NSLog(@"thread start");
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer---%@", weakSelf);
    }];
    // 当前RunLoop要添加source事件，比如定时器或者添加Port事件，要有事情做，不然还是会休眠
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    [self.timer fire];
    NSLog(@"thread end");
}

// 添加RunLoop监听
- (void)addRunLoopObserver {
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(
                                                                       CFAllocatorGetDefault(),
                                                                       kCFRunLoopAllActivities,
                                                                       YES,
                                                                       0,
                                                                       ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        // 状态
        if (activity == kCFRunLoopEntry) { // 即将进入RunLoop
            NSLog(@"kCFRunLoopEntry");
        } else if (activity == kCFRunLoopBeforeTimers) { // 即将处理timer事件
            NSLog(@"kCFRunLoopBeforeTimers");
        } else if (activity == kCFRunLoopBeforeSources) { // 即将处理source事件
            NSLog(@"kCFRunLoopBeforeSources");
        } else if (activity == kCFRunLoopBeforeWaiting) { // 即将休眠
            NSLog(@"kCFRunLoopBeforeWaiting");
        } else if (activity == kCFRunLoopAfterWaiting) { // 即将唤醒
            NSLog(@"kCFRunLoopAfterWaiting");
        } else if (activity == kCFRunLoopExit) { // 即将退出RunLoop
            NSLog(@"kCFRunLoopExit");
        }
    });
    // 添加主线程的RunLoop监听操作
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 用户要主动释放定时器
    [self.timer invalidate];
}

- (void)dealloc {
    NSLog(@"%s", __func__);

}

@end
