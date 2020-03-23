//
//  main.m
//  11-load
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+Category1.h"
#import "Person+Category2.h"
#import "Student.h"
#import "Student+Category1.h"
#import "Student+Category2.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        /**
         load 总结：
         1、main函数之前调用，动态加载类的时候调用
         2、优先加载类的load、后加载分类的load  call_class_loads/call_category_loads
         3、加载类的顺序，先加载父类的load方法，逐级查找，再加载子类load方法
         4、分类的load方法先编译先调用
         5、通过函数指针调用，不是通过消息机制调用
         */
        
    }
    return 0;
}
