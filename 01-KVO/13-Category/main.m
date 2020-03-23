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
        
    }
    return 0;
}
