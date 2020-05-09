//
//  NSMutableArray+Safe.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Swizzled.h"
#import <objc/runtime.h>
#import "CrashLog.h"

@implementation NSMutableArray (Safe)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [objc_getClass("__NSArrayM") swizzleInstanceObjMethod:@selector(objectAtIndexedSubscript:) swizzledSEL:@selector(zc_objectAtIndexedSubscript:)];
        [objc_getClass("__NSArrayM") swizzleInstanceObjMethod:@selector(insertObject:atIndex:) swizzledSEL:@selector(zc_insertObject:atIndex:)];

        
    });
}


- (id)zc_objectAtIndexedSubscript:(NSUInteger)idx {
    if (self.count == 0 || idx > self.count -1) {
        @try {
            return [self zc_objectAtIndexedSubscript:idx];
        } @catch (NSException *exception) {
//            NSLog(@"callStackSymbols：%@", [exception callStackSymbols]);
//            NSLog(@"exception.reason：%@", exception.reason);
            [CrashLog zc_errorWithException:exception];
            return nil;
        } @finally {

        }
    } else {
        return [self zc_objectAtIndexedSubscript:idx];
    }
}

- (void)zc_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil || index > self.count) {
        @try {
            [self zc_insertObject:anObject atIndex:index];
        } @catch (NSException *exception) {
//            NSLog(@"callStackSymbols：%@", [exception callStackSymbols]);
//            NSLog(@"exception.reason：%@", exception.reason);
            [CrashLog zc_errorWithException:exception];
        } @finally {
            
        }
    } else {
        [self zc_insertObject:anObject atIndex:index];
    }
}


@end
