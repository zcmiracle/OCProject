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

    }
    return 0;
}
