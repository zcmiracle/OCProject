//
//  main.m
//  08-Block循环引用
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Test.h"
int num = 0;

int main(int argc, const char * argv[]) {

    //        // 循环引用1：自循环引用
    //        Test *test = [[Test alloc] init];
    //        test.name = @"Fearless";
    //
    //        // 解除循环引用方式1 weak
    ////        [test weakMethod];
    //
    //        // 解除循环引用方式2 __block
    //        [test blockMethod];
    
    
    // --------------------------------------------------
    
    //        NSObject *self = [NSObject new];
    //        __weak NSObject *weakSelf = self;
    //
    //        NSLog(@"%ld", CFGetRetainCount((__bridge CFTypeRef)(self)) );
    //        void(^weakBlock)(void) = ^{
    ////            NSLog(@"---%ld", CFGetRetainCount((__bridge CFTypeRef)(self)));
    //            NSLog(@"---%ld", CFGetRetainCount((__bridge CFTypeRef)(weakSelf)));
    //        };
    //
    //        weakBlock();
    // --------------------------------------------------
    
//    int a = 100;
//    // weakBlock   __NSStackBlock__
//    void(^ __weak weakBlock)(void) = ^{
//        NSLog(@"%d", a);
//    };
//
//    // strongBlock1  __NSStackBlock__
////    void(^ __strong strongBlock1)(void) = weakBlock;
//
//    // strongBlock2  __NSMallocBlock__
//    void(^ __strong strongBlock2)(void) = [weakBlock copy];
//
////    strongBlock1();
//    strongBlock2();
    
    
    // --------------------------------------------------

//    void(^ __weak weakBlock1)(void) = nil;
//
//    {
//        int b = 2;
//        void(^ __weak weakBlock2)(void) = ^{
//            NSLog(@"%d", b);
//        };
//
//        // 结构体的赋值
//        weakBlock1 = weakBlock2;
//    }
//
//    weakBlock1();
    
    
    // --------------------------------------------------

//    int a = 0;
//    void(^ __weak weakBlock1)(void) = nil;
//
//    {
//        void(^__strong strongBlock1)(void) = ^{
//            NSLog(@"%d", a);
//        };
//        weakBlock1 = strongBlock1;
//    }
//
//    // Thread 1: EXC_BAD_ACCESS (code=1, address=0x10)
//    weakBlock1();
    
    
    // --------------------------------------------------
//    NSObject *objc = [NSObject new];
//    NSLog(@"%ld", CFGetRetainCount((__bridge CFTypeRef)(objc))); // 1
//
//    // objc 连同其所有权修饰符 __strong 一起捕获
//    void(^block1)(void) = ^{
//        NSLog(@"---%ld", CFGetRetainCount((__bridge CFTypeRef)(objc))); // 3
//    };
//    block1();
//
//    void(^__weak block2)(void) = ^{
//        NSLog(@"---%ld", CFGetRetainCount((__bridge CFTypeRef)(objc))); // 4
//    };
//    block2();
//
//    void(^block3)(void) = [block2 copy]; // 5
//    block3();
//
//    __block NSObject *obj = [NSObject new];
//    void(^block4)(void) = ^{
//        NSLog(@"---%ld", CFGetRetainCount((__bridge CFTypeRef)(obj))); // 1
//    };
//    block4();
    
#if 0
    struct __main_block_impl_0 {
        struct __block_impl impl;
        struct __main_block_desc_0* Desc;
        // 强引用 引用计数 + 1
        NSObject *__strong objc;
        __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, NSObject *__strong _objc, int flags=0) : objc(_objc) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
    static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
        // 强引用 引用计数 + 1
        NSObject *__strong objc = __cself->objc; // bound by copy
        NSLog((NSString *)&__NSConstantStringImpl__var_folders__9_hnm3f8815kzgrmhn4q8x07600000gn_T_main_320a9b_mi_1, CFGetRetainCount((__bridge CFTypeRef)(objc)));
    }
    
#endif
    
    
    // --------------------------------------------------
    
    //    int a = 10;
    //    void(^ __weak weakBlock)(void) = ^{
    //        NSLog(@"%d", a);
    //    };
    //
    //    dispatch_block_t dispatch_block = ^{
    //        weakBlock();
    //    };
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), dispatch_block);
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    
    // --------------------------------------------------

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

 
}




