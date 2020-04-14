//
//  main.m
//  13-Category
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"
#import "Person+Category1.h"
#import "Person+Category2.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
  
        Person *person = [[Person alloc] init];
        [person test];
        // 私有方法前向引用
        [person ExtensionPrivateMethod];
        // 类的.m文件中实现，类和分类的.h都没有声明
        [person performSelector:@selector(noInterfacePrivateMethod)];
        // 分类的.m文件中实现，类和分类的.h都没有声明
        [person performSelector:@selector(noInterfaceCategoryPrivateMethod)];

        // 调用person中的test方法
        unsigned int count = 0;
        Method *methodList = class_copyMethodList([Person class], &count);
        IMP imp = NULL;
        SEL sel = NULL;
        for (unsigned int i = 0; i < count; i ++) {
            Method method = methodList[i];
            SEL methodSEL = method_getName(method);
            NSString *methodName = [NSString stringWithUTF8String:sel_getName(methodSEL)];
            if ([methodName isEqualToString:@"test"]) {
                imp = method_getImplementation(method);
                sel = method_getName(method);
            }
        }
        // 通过函数指针调用类中的test方法
        ((void(*)(id, SEL))(void *)imp)(person, sel);
        free(methodList);
        
        // No visible @interface for 'Person' declares the selector 'noInterfacePrivateMethod'
        // [person noInterfacePrivateMethod];
        // No visible @interface for 'Person' declares the selector 'noInterfaceCategoryPrivateMethod'
        // [person noInterfaceCategoryPrivateMethod];

        
        // 后编译的先调用 while(i--)
        
        // runtime动态加载类的时候。合并分类的数据
        // _objc_init() 入口函数
        // map_images  加载镜像 加锁操作
        // map_images_nolock  完成所有类的注册和fixup操作，一些初始化工作以及load方法的调用
        // _read_images 完成类的加载、协议的加载、分类的加载等工作
        // remethodizeClass 分类绑定到原类上
        // attachCategories 分类中的方法和属性和协议绑定到目标类上
        // attachLists 原类中的方法和分类中的方法放到一个列上
    }
    return 0;
}
