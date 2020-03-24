//
//  main.m
//  16-msgForward
//
//  Created by XFB on 2020/3/24.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        /**
         -[ZCPerson run]: unrecognized selector sent to instance 0x10051ee30
         Terminating app due to uncaught exception 'NSInvalidArgumentException',
         reason: '-[ZCPerson run]: unrecognized selector sent to instance 0x10051ee30'
         */
        // _objc_msgForward消息转发 
         ((void(*)(id, SEL))_objc_msgForward)([ZCPerson new], @selector(run));
        
        /**
         总结：
         1、_objc_msgForward是一个函数地址即IMP，用于消息转发
         2、当一个对象执行未实现的方法时，会调用此方法
         3、resolveClassMethod和resloveInstanceMethod不属于消息转发流程（动态方法解析）
         */
        
    }
    return 0;
}
