//
//  main.m
//  20-字典转模型
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "ZCPersonModel1.h"
#import "ZCPersonModel2.h"
#import "ZCPersonModel3.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // 1、正常字典key-value
        
        // 2、字典嵌套字典
        
        // 3、字典嵌套数组，数组中多个字典

        
        
    }
    return 0;
}

#if 0

// 获取属性列表
class_copyPropertyList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)

// 获取属性名
property_getName(<#objc_property_t  _Nonnull property#>)

// 特殊情况
NSNumber 转换成对应的字符串
NSNull 转换成空字符串
处理字典中的特殊key，比如id和new等

#endif
