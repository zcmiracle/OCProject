//
//  main.m
//  04-KVC赋值
//
//  Created by XFB on 2020/3/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCObserver.h"
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Student *student = [[Student alloc] init];
        [student setValue:@"Fearless" forKey:@"name"];

        ZCObserver *observer = [[ZCObserver alloc] init];
        [student addObserver:observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        /**
         setValue:forKey：原理
         1、先调用 setKey、没有就调用 _setKey
         2、都没有调用，根据 accessInstanceVariableDirectly
         根据返回值判断是否访问成员变量，NO不返回成员变量，YES返回成员变量
         3、根据_key、_isKey、key、isKey的顺序访问成员变量，找到成员变量，直接赋值
         KVC修改属性会触发KVO监听
         
         */
        [student setValue:@"Miracle" forKey:@"name"];
        // KVC直接修改成员变量，会触发willChangeValueForKey和didChangeValueForKey
        // willChangeValueForKey
        // 修改成员变量
        // didChangeValueForKey
        [student removeObserver:observer forKeyPath:@"name"];
    
    }
    return 0;
}
