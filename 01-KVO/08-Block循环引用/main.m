//
//  main.m
//  08-Block循环引用
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // 循环引用1：自循环引用
        Test *test = [[Test alloc] init];
        test.name = @"Fearless";
        
        // 解除循环引用方式1 weak
//        [test weakMethod];
        
        // 解除循环引用方式2 __block
        [test blockMethod];
    }
        
    NSLog(@"---end---");
    
    return 0;
}
