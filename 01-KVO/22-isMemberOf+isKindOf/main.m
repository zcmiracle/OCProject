//
//  main.m
//  22-isMemberOf+isKindOf
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSObject *obj = [[NSObject alloc] init];
        Test *test = [[Test alloc] init];
        
        NSLog(@"%d", [obj isKindOfClass:[NSObject class]]); // 1
        NSLog(@"%d", [obj isMemberOfClass:[NSObject class]]); // 1
        NSLog(@"%d", [test isKindOfClass:[Test class]]); // 1
        NSLog(@"%d", [test isMemberOfClass:[Test class]]); // 1

         
        NSLog(@"%d", [NSObject isKindOfClass:[NSObject class]]); // 1
        NSLog(@"%d", [NSObject isMemberOfClass:[NSObject class]]); // 0
        NSLog(@"%d", [Test isKindOfClass:[Test class]]); // 0
        NSLog(@"%d", [Test isMemberOfClass:[Test class]]); // 0
        
        
        NSLog(@"%d", [NSObject isKindOfClass:object_getClass([NSObject class])]); // 1
        NSLog(@"%d", [NSObject isMemberOfClass:object_getClass([NSObject class])]); // 1
        NSLog(@"%d", [Test isKindOfClass:object_getClass([Test class])]); // 1
        NSLog(@"%d", [Test isMemberOfClass:object_getClass([Test class])]); // 1
    }
    return 0;
}


#if 0

+ (BOOL)isMemberOfClass:(Class)cls {
    return object_getClass((id)self) == cls;
}

- (BOOL)isMemberOfClass:(Class)cls {
    return [self class] == cls;
}

+ (BOOL)isKindOfClass:(Class)cls {
    for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
        if (tcls == cls) return YES;
    }
    return NO;
}

- (BOOL)isKindOfClass:(Class)cls {
    for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
        if (tcls == cls) return YES;
    }
    return NO;
}


#endif
