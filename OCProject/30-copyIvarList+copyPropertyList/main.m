//
//  main.m
//  30-copyIvarList+copyPropertyList
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCTest.h"
#import "RuntimeKit.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        ZCTest *test = [[ZCTest alloc] init];
        
        NSArray *propertyList = [RuntimeKit fetchPropertyList:[test class]];
        NSArray *ivarList = [RuntimeKit fetchIvarList:[test class]];
        
        NSLog(@"propertyList --- %@", propertyList);
        NSLog(@"ivarList --- %@", ivarList);
        
        /**
          property会获取到成员变量
          ivar还会获取到私有成员变量 在.m文件中的
         
          propertyList --- (
                 {
                 propertyAttributes = "T@\"NSString\",C,N,V_age";
                 propertyName = age;
             }
         )
         
         ivarList --- (
                 {
                 ivarName = "_name";
                 ivarType = "@\"NSString\"";
             },
                 {
                 ivarName = "_userName";
                 ivarType = "@\"NSString\"";
             },
                 {
                 ivarName = height;
                 ivarType = "@\"NSString\"";
             },
                 {
                 ivarName = "_width";
                 ivarType = "@\"NSString\"";
             },
                 {
                 ivarName = "_age";
                 ivarType = "@\"NSString\"";
             }
         )
         */
        
    }
    return 0;
}
