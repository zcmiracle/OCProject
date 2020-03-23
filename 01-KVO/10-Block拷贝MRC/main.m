//
//  main.m
//  10-Block拷贝MRC
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

typedef void(^MRCBlock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int age = 10;
        // __NSGlobalBlock__
        MRCBlock globalBlock = ^{

        };
        NSLog(@"GlobalBlock：%@", [globalBlock class]);

        // __NSStackBlock__
        MRCBlock stackBlock = ^{
            NSLog(@"%d", age);
        };
        NSLog(@"StackBlock：%@", [stackBlock class]);

        // __NSStackBlock__
        // MRC是栈区Block
        // ARC是堆区Block
        void(^StackBlock)(void) = ^{
            NSLog(@"%d", age);
        };
        NSLog(@"StackBlock：%@", [StackBlock class]);
        
        // __NSMallocBlock__ MRC下手动调用copy方法
        void(^MallocBlock)(void) = [^{
            NSLog(@"%d", age);
        } copy];
        NSLog(@"MallocBlock：%@", [MallocBlock class]);
                
        Person *person = [[Person alloc] init];
        person.name = @"Fearless";
        [person method];
        [person release];
    }
    return 0;
}
