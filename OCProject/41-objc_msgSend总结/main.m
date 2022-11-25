//
//  main.m
//  41-objc_msgSend总结
//
//  Created by XFB on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "Student.h"
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Student *student = [[Student alloc] init];
        Person *person = [[Person alloc] init];
        [person playing];
        [Person sleeping];
        
        // objc_msg --> NO
        SEL playingSEL = @selector(playing);
        SEL sleepingSEL = NSSelectorFromString(@"sleeping");
        objc_msgSend(person, playingSEL);
        objc_msgSend([Person class],sleepingSEL);
        
        /**
         objc_msgSend_stret：消息返回的是结构体
         objc_msgSend_fpret：消息返回的是浮点数
         objc_msgSendSuper：给父类发消息
         */
        struct objc_super objSuper;
        objSuper.receiver = student;
        objSuper.super_class = [Person class];
        // student执行了父类方法 <Student: 0x10303e070> 消息接收者还是自己，并不是父类
        objc_msgSendSuper(&objSuper, @selector(playing));
    }
    return 0;
}


#if 0

objc_msgSendSuper(struct objc_super *super, SEL op)

struct objc_super {
    __unsafe_unretained _Nonnull id receiver;
    __unsafe_unretained _Nonnull Class super_class;
};

#endif
