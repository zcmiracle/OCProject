//
//  main.m
//  17-类添加property变化
//
//  Created by Fearless on 2020/3/24.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyModel.h"
#import "RuntimeKit.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // 给类添加一个属性后，在类结构体里 哪些元素会发生变化？？？
        Class cls = [PropertyModel class];

        
        // 【添加属性的方式1】：@property(nonatomic, copy) NSString *name;
        // class_ro_t ---> instance：实例大小
        // class_ro_t ---> ivar_list_t：变量列表
        // class_rw_t ---> property_list_t：属性列表
        // class_rw_t ---> method_list_t：方法列表 主要是setter和getter方法增加
     
//        // 1、获得instance size
//        NSLog(@"instance1：%ld", class_getInstanceSize(cls));
//        // 2、获取成员变量列表
//        NSArray *ivarList1 = [RuntimeKit fetchIvarList:cls];
//        NSLog(@"ivarList1：%@", ivarList1);
//        // 3、获取属性列表
//        NSArray *propertyList1 = [RuntimeKit fetchPropertyList:cls];
//        NSLog(@"propertyList1：%@", propertyList1);
//        // 4、方法列表
//        NSArray *methodList1 = [RuntimeKit fetchMethodList:cls];
//        NSLog(@"methodList1：%@", methodList1);
        
        /**
            **********没有添加属性**********
         instance1：8
         ivarList1：(
         )
         propertyList1：(
         )
         methodList1：(
         )
         
                
            **********添加了属性**********
         instance1：16
         ivarList1：(
                 {
                 ivarName = "_name";
                 ivarType = "@\"NSString\"";
             }
         )
         propertyList1：(
                 {
                 propertyAttributes = "T@\"NSString\",C,N,V_name";
                 propertyName = name;
             }
         )
         methodList1：(
                 {
                 methodName = ".cxx_destruct";
                 methodType = "v16@0:8";
             },
                 {
                 methodName = name;
                 methodType = "@16@0:8";
             },
                 {
                 methodName = "setName:";
                 methodType = "v24@0:8@16";
             }
         )
         */
        
        
        
        // 【添加属性的方式2】：class_addProperty
        // class_rw_t ---> property_list_t：属性列表
        // 因为编译后的类不能动态添加实例变量(成员变量ivar)
        // 所有instance：实例大小不会变化，变量列表也不会
        // 也不会生成setter和getter方法，所以method_list_t 也不会发生变化
        // 只有属性列表会发生变化，因为你添加了属性
        const char *name = "T";
        const char *value = [[NSString stringWithFormat:@"\"%@\"", NSStringFromClass([NSString class])] UTF8String];
        objc_property_attribute_t type = { name, value };
        objc_property_attribute_t ownership0 = {"C", ""};       // C = copy
        objc_property_attribute_t ownership = {"N", ""};        // N = nonatomic
        objc_property_attribute_t backingivar = {"V", "_age"}; // variable name
        objc_property_attribute_t attrs[] = { type, ownership0, ownership, backingivar };
        class_addProperty(cls, "age", attrs, 4);
        
        NSLog(@"instance1：%ld", class_getInstanceSize(cls));
        // 2、获取成员变量列表
        NSArray *ivarList1 = [RuntimeKit fetchIvarList:cls];
        NSLog(@"ivarList1：%@", ivarList1);
        // 3、获取属性列表
        NSArray *propertyList1 = [RuntimeKit fetchPropertyList:cls];
        NSLog(@"propertyList1：%@", propertyList1);
        // 4、方法列表
        NSArray *methodList1 = [RuntimeKit fetchMethodList:cls];
        NSLog(@"methodList1：%@", methodList1);
       
        /**
          **********添加属性方式2**********
         instance1：8
         ivarList1：(
         )
         propertyList1：(
                 {
                 propertyAttributes = "T\"NSString\",C,N,V_age";
                 propertyName = age;
             }
         )
         methodList1：(
         )
         */
        
    }
    return 0;
}
