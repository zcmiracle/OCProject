//
//  main.m
//  09-Block拷贝ARC
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MallocBlock2)(void);

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
                
        MallocBlock2 block2 = ^{
            NSLog(@"%d", age);
        };
        
    
//        void(^MallocBlock)(void) = MallocBlock block
        
        /**
         block发生copy的时机：5个
         1、block赋值给有__strong修饰符id类型的类，或者Block类型成员变量时
         2、手动调用copy方法
         3、block作为函数返回值
         4、含有userBlock的API
         5、block作为GCD API的方法参数
         */
        
        /**
         2020-03-23 16:40:18.075650+0800 09-Block拷贝ARC[6011:1185381] GlobalBlock：__NSGlobalBlock__ <===> 0x100001068
         2020-03-23 16:40:18.076153+0800 09-Block拷贝ARC[6011:1185381] StackBlock：__NSStackBlock__ <===> 0x7fff8f676070
         2020-03-23 16:40:18.076228+0800 09-Block拷贝ARC[6011:1185381] MallocBlock：__NSMallocBlock__ <===> 0x102044dd0
         */
        
        
        
    }
    return 0;
}
