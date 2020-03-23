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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
  
        Person *person = [[Person alloc] init];
        [person test];
     
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
