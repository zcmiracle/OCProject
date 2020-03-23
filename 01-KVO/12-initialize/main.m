//
//  main.m
//  12-initialize
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+Category1.h"
#import "Person+Category2.h"
#import "Student.h"
#import "Student+Category1.h"
#import "Student+Category2.h"
#import "Teacher.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        [Student alloc]; 
        [Teacher alloc];
        [Person alloc];

        /**
         initialize总结：
         1、第一次执行类的时候调用
         2、initialize使用消息发送流程 objc_msgSend()
         3、初始化类的时候，先调用父类的initialize，再调用子类的initialize(如果子类没有实现，通过superclass找到父类进行方法调用)
         4、调用父类的initialize时候，有分类先加载分类的initialize
         5、加载分类的initialize时，按照 后编译的先调用，和load方法相反
         
         父类的initialize可能会调用多次，比如子类没有实现initialize
         
         */
        
    }
    return 0;
}
