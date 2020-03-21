//
//  main.m
//  06-Block变量捕获
//
//  Created by XFB on 2020/3/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

// 全局变量
int globalAge = 10;
// 静态全局变量
static int staticGlobalAge = 20;

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-12.0.0 main.m
        
        // 基本数据类型
        int age = 30;
        // 对象类型 局部变量
        __strong NSObject *obj = [[NSObject alloc] init];
        // 静态局部变量
        static int staticAge = 40;
        
        void(^Block)(void) = ^{
            NSLog(@"局部变量---基本数据类型：%d", age);
            NSLog(@"局部变量---对象类型：%@", obj);
            NSLog(@"静态局部变量：%d", staticAge);
            NSLog(@"全局变量：%d", globalAge);
            NSLog(@"静态全局变量：%d", staticGlobalAge);
        };
        Block();
    }
    return 0;
}
