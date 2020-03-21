//
//  main.m
//  05-KVC取值
//
//  Created by XFB on 2020/3/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "ZCObserver.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Student *student = [[Student alloc] init];
//        student->name = @"name";
//        student->isName = @"isName";
//        student->_name = @"_name";
//        student->_isName = @"_isName";
//        student.name = @"Fearless";
        NSLog(@"valueForKey === %@", [student valueForKey:@"name"]);

        /**
         valueForKey的取值
         getKey key _isKey _key 和setValueForKey反过来只不过isKey改成getKey
         */
        
    }
    return 0;
}
