//
//  main.m
//  15-runtime添加ivar
//
//  Created by XFB on 2020/3/24.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 能否向编译后得到的类增加实例变量ivars？能否向运行时创建的类添加实例变量？为什么？
        
        // 1、编译后的类添加实例变量(成员变量ivars)
//        class_addIvar([UserModel class], "name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
//        UserModel *user = [[UserModel alloc] init];
//        [user setValue:@"Fearless" forKey:@"name"];
//        NSLog(@"%@", [user valueForKey:@"name"]);
        /**
         Terminating app due to uncaught exception 'NSUnknownKeyException',
         reason: '[<UserModel 0x10180c460> setValue:forUndefinedKey:]:
         this class is not key value coding-compliant for the key name.'
         */
        
        // 2、运行时创建的类添加实例变量(成员变量ivars)
        Class cls = objc_allocateClassPair([NSObject class], "Animate", 0);
        class_addIvar(cls, "name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
        objc_registerClassPair(cls);
        
        id animate = [[cls alloc] init];
        [animate setValue:@"Fearless" forKey:@"name"];
        NSLog(@"%@", [animate valueForKey:@"name"]);
        
        /**
         总结：
         1、类编译时只读结构体class_ro_t就会被确定，运行时不可修改
         2、ro结构体中的ivar_list_t也是不可修改的，并且instanceSize决定了创建对象时需要的空间大小
         3、在objc_allocateClassPair和objc_registerClassPair之间调用class_addIvar
         
         objc_allocateClassPair     // alloc一个类
         class_addIvar              // 添加成员变量
         objc_registerClassPair     // 注册类
         */
        
    }
    return 0;
}
