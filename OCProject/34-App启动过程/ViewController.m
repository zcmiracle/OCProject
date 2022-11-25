//
//  ViewController.m
//  34-App启动过程
//
//  Created by Fearless on 2020/4/4.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"


@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *mArray;

@end

@implementation ViewController

- (NSMutableArray *)mArray{
    if (!_mArray) _mArray = [NSMutableArray arrayWithCapacity:1];
    return _mArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    dispatch_queue_t queue = dispatch_queue_create("cooci", DISPATCH_QUEUE_CONCURRENT);
//    NSLog(@"1");
//    dispatch_async(queue, ^{
//        NSLog(@"2");
//        dispatch_sync(queue, ^{
//            NSLog(@"3");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"5");
    
//    dispatch_queue_t queue = dispatch_queue_create("cooci", NULL);
//    NSLog(@"1");
//    dispatch_async(queue, ^{
//        NSLog(@"2");
//        dispatch_sync(queue, ^{
//            NSLog(@"3");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"5");
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    self.mArray = arr;

    // 全局变量不捕获self.mArray
    // 捕获局部变量 arr
//    void (^kcBlock)(void) = ^{
//        [arr addObject:@"3"];
//        [self.mArray addObject:@"a"];
//        NSLog(@"KC %@",arr);
//        NSLog(@"Cooci: %@",self.mArray);
//    };
//    [arr addObject:@"4"];
//    [self.mArray addObject:@"5"];
//
//    arr = nil;
//    self.mArray = nil;
//    kcBlock();
//
//    int a = 0;
//    void(^ __weak weakBlock)(void) = ^{
//        NSLog(@"-----%d", a);
//    };
//
//    struct _LGBlock *blc = (__bridge struct _LGBlock *)weakBlock;
//    id __strong strongBlock = [weakBlock copy];
////    blc->invoke = nil;
//    void(^strongBlock1)(void) = strongBlock;
//    strongBlock1();


    
//    NSObject *a = [NSObject alloc];
//    void(^__weak block1)(void) = nil;
//    {
//        // 默认是 __strong
//        void(^block2)(void) = ^{
//            NSLog(@"---%@", a);
//        };
//        // 结构体复制 一样
//        block1 = block2;
//        NSLog(@"1 - %@ - %@",block1, block2);
//    }
//    block1();

    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    PresentViewController *vc = [[PresentViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];    
}

- (IBAction)changeAnchorPoint:(UIButton *)sender {
    
}

@end
