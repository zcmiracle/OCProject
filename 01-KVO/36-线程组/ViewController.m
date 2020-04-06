//
//  ViewController.m
//  36-线程组
//
//  Created by Fearless on 2020/4/6.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    dispatch_queue_t ioQueue;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    ioQueue = dispatch_queue_create("ioQueue", DISPATCH_QUEUE_CONCURRENT);
    [self groupGCDDemo];
}

/**
 group组，看做当前任务计数，当任务为0时，执行dispatch_group_notify
 dispatch_group_enter 当前任务 +1
 dispatch_group_leave 当前任务 -1
 */
- (void)groupGCDDemo {
 
    dispatch_group_t group = dispatch_group_create();
    NSInteger taskCount = 3;
    for (NSInteger i = 0; i < taskCount; i ++) {
        // 添加3个任务，任务数为3
        dispatch_group_enter(group);
        // 开启线程去完成任务
        dispatch_async(ioQueue, ^{
            NSLog(@"完成任务：%ld", i);
            // 任务数 -1
            dispatch_group_leave(group);
        });
    }
    
    dispatch_group_notify(group, ioQueue, ^{
        NSLog(@"所有任务都完成，合成图片");
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self groupGCD];
}


// 伪代码
- (void)groupGCD {
    dispatch_group_t group = dispatch_group_create();
    NSInteger taskCount = 3;
    for (NSInteger i = 0; i < taskCount; i ++) {
        dispatch_group_enter(group);
        NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com_%ld", i];
        [self downLoadNetData:urlString group:group];
    }
    
    dispatch_group_notify(group, ioQueue, ^{
        NSLog(@"所有任务都完成，合成图片");
    });
    
}

// 网络任务
- (void)downLoadNetData:(NSString *)urlString group:(dispatch_group_t)group {
    dispatch_async(ioQueue, ^{
        NSLog(@"正在下载任务：%@", urlString);
        
        sleep(random()%5); // 网络下载
        NSLog(@"完成任务：%@", urlString);
        // 任务数 -1
        dispatch_group_leave(group);
    });
}

@end
