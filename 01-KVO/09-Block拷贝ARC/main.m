//
//  main.m
//  09-Block拷贝ARC
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MallocBlock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
   
        int age = 10;
        // __NSGlobalBlock__ 全局区
        void(^GlobalBlock)(void) = ^{
            
        };
        NSLog(@"GlobalBlock：%@ <===> %p", [GlobalBlock class], GlobalBlock);

        
        // __NSStackBlock__ 栈区
        NSLog(@"StackBlock：%@ <===> %p", [^(void){
            NSLog(@"%d", age);
        } class], [^(void){
            NSLog(@"%d", age);
        } class]);
        
        
        // __NSMallocBlock__ 堆区
        void(^MallocBlock)(void) = ^{
            NSLog(@"%d", age);
        };
        NSLog(@"MallocBlock：%@ <===> %p", [MallocBlock class], MallocBlock);
        
        /**
         block发生copy的时机：5个
         1、block赋值给有__strong修饰符id类型的类，或者Block类型成员变量时
         2、手动调用copy方法
         3、block作为函数返回值
         4、含有userBlock的API
         5、block作为GCD API的方法参数
         */
        
    }
    return 0;
}
