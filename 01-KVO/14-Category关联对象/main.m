//
//  main.m
//  14-Category关联对象
//
//  Created by Fearless on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+Category.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
 
        Person *person = [[Person alloc] init];
        person.name = @"Fearless";
        NSLog(@"%@", person.name);

        [person setValue:@"Miracle" forKey:@"name"];
        NSLog(@"%@", person.name);
        
        /**
         关联对象实现原理：
         1、关联对象存储在一个全局容器中，由一个AssociationManager来管理
         AssociationManager里面有一个成员变量 AssociationHaspMap 哈希表
         哈希表的key是传递的关联对象的地址值经过位运算取反 对应的value = ObjectAssociationMap
                  ObjectAssociationMap管理者这个对象所有的关联值，也是一张map表
         key：用户手动传过去的key，value由用户传过去的value和policy组装的对象
         首先判断这个haspMap存在不。如果存在通过传过去的key判断ObjcAssociation 存在不，
         不存在将policy和key包装成一个对象，然后赋值，如果不存在，则将传过去的Policy和value包装成
         一个ObjcAssociation 然后赋值
         如果这个haspMap不存在，则新建ObjectAssociationMap 然后将policy和value包装成一个对象
         ObjcAssociation，最后将ObjcAssociation和key关联，
         */
        
        // 使用runtime Associate方法关联的对象，需要在主对象dealloc的时候释放吗？
        // 不需要释放
        // 主对象引用计数位0时，调用 release
        // 沿继承链 调用父类的dealloc
        // 直到调用NSObject的dealloc
        // 经过一系列函数调用栈
        // dealloc-->
        // _objc_rootDealloc-->
        // rootDealloc-->
        // object_dispose-->
        // objc_destructInstance 释放成员变量 + 移除关联属性 + 弱引用指向nil
        // free(this), free(obj)
        
    }
    return 0;
}
