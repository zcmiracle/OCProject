
//
//  ThreadViewController.m
//  26-线程保活
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ThreadViewController.h"
#import "ZCThread.h"
#import "PermenantThread.h"

@interface ThreadViewController ()

// 封装的
@property (nonatomic, strong) PermenantThread *thread1;

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.thread1 = [[PermenantThread alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 执行任务
    [self.thread1 executeTaskWithBlock:^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
    }];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
