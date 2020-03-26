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
#import "ZCBaseModel.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // 1、正常字典key-value  包含NSNumber NSNull
        NSDictionary *dict1 = @{
            @"id" : @"12345",
            @"name" : @"Fearless",
            @"age" : @20,
            @"money" : [NSNull null],
        };
        ZCPersonModel1 *personModel1 = [[ZCPersonModel1 alloc] initWithDataDict:dict1];
        NSLog(@"id = %@, name = %@, age = %@, money = %@", personModel1.personID,
              personModel1.name,
              personModel1.age,
              personModel1.money);
        
        // 2、字典嵌套字典
        NSDictionary *dict2 = @{
            @"name" : @"Miracle",
            @"student" : @{
                @"age" : @20,
            },
        };
        ZCPersonModel2 *personModel2 = [[ZCPersonModel2 alloc] initWithDataDict:dict2];
        NSLog(@"name = %@, student.age = %@", personModel2.name,
              personModel2.student.age);
        
        // 3、字典嵌套数组，数组中多个字典
        NSDictionary *dict3 = @{
            @"name" : @"LBJ",
            @"students" : @[
                    @{
                        @"age" : @20,
                        @"name" : @"James"
                    },
                    @{
                        @"age" : @30,
                        @"name" : @"韦德",
                    },
            ],
        };
        ZCPersonModel3 *personModel3 = [[ZCPersonModel3 alloc] initWithDataDict:dict3];
        NSLog(@"person.name = %@", personModel3.name);
        for (ZCStudentModel *student in personModel3.students) {
            NSLog(@"student.name = %@, student.age = %@", student.name, student.age);
        }

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
