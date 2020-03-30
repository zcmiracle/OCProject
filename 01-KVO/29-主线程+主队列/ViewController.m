//
//  ViewController.m
//  29-主线程+主队列
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"begin --- %@",[NSThread currentThread]);
    // 系统方法，获取全局的并行队列
    //    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    
    // 结论
    // 主队列中的任务在主线程中执行
    // 主线程执行的任务不一定是主队列的，全局并发队列使用sync同步函数
    
    // 自己创建的全局并发
    dispatch_queue_t globalQueue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    for (NSInteger index = 0; index < 3; index++) {
        dispatch_sync(globalQueue, ^{
            NSLog(@"index:%ld --- %@", index, [NSThread currentThread]);
        });
    }
    NSLog(@"end --- %@", [NSThread currentThread]);
}


@end
