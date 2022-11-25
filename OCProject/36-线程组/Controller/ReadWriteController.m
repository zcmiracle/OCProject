//
//  ReadWriteController.m
//  36-线程组
//
//  Created by XFB on 2020/4/7.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ReadWriteController.h"

@interface ReadWriteController ()
{
    dispatch_queue_t _ioQueue;
}

@property (nonatomic, strong) NSMutableArray *mutableArray;

@end

@implementation ReadWriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"读写锁";
    // 并行队列
    _ioQueue = dispatch_queue_create("ioQueue", DISPATCH_QUEUE_CONCURRENT);
    _mutableArray = [NSMutableArray array];

    // GCD Barrier
    [self gcdBarrier];
}

- (void)gcdBarrier {
    
    dispatch_async(_ioQueue, ^{
        NSLog(@"任务1");
    });
    
    dispatch_async(_ioQueue, ^{
        NSLog(@"任务2");
    });
    
    dispatch_async(_ioQueue, ^{
        NSLog(@"任务3");
    });
    
    // barrierz栅拦函数
    dispatch_barrier_async(_ioQueue, ^{
        NSLog(@"barrier start");
        sleep(1);
        NSLog(@"barrier end");
    });
    
    
    dispatch_async(_ioQueue, ^{
        NSLog(@"任务4");
    });
    dispatch_async(_ioQueue, ^{
        NSLog(@"任务5");
    });
}


// 写操作
- (void)addObject:(NSString *)object {
    // object是mutable可变对象，防止外部马上变化，所以copy
    object = [object copy];
    dispatch_barrier_async(_ioQueue, ^{
        if (object) {
            // 这里是使用不是赋值 可以不用__block
            [self.mutableArray addObject:object];
        }
    });
}

// 读操作
- (NSString *)objectForIndex:(NSInteger)index {
    __block NSString *result = nil;
    dispatch_sync(_ioQueue, ^{
        if (index < self.mutableArray.count) {
            result = self.mutableArray[index];
        }
    });
    return result;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 清空数据
    [_mutableArray removeAllObjects];
    
    for (NSInteger i = 0; i < 50; i ++) {
        // 全局并发队列 写入数据
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self addObject:[@(i) description]];
        });
        
        // 读取数据
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"%ld---%@", i ,[self objectForIndex:i]);
        });
    }
}

@end
