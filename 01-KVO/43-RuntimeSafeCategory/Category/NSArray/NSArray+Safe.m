//
//  NSArray+Safe.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Swizzled.h"
#import <objc/runtime.h>
#import "CrashLog.h"

@implementation NSArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [objc_getClass("__NSPlaceholderArray") swizzleInstanceObjMethod:@selector(initWithObjects:count:) swizzledSEL:@selector(zc_initWithObjects:count:)];
        [objc_getClass("__NSArrayI") swizzleInstanceObjMethod:@selector(objectAtIndexedSubscript:) swizzledSEL:@selector(zc_objectAtIndexedSubscript:)];
        [objc_getClass("__NSArray0") swizzleInstanceObjMethod:@selector(objectAtIndex:) swizzledSEL:@selector(zc_objectAtIndex:)];
        [objc_getClass("__NSSingleObjectArrayI") swizzleInstanceObjMethod:@selector(objectAtIndex:) swizzledSEL:@selector(zc_singleObjectAtIndex:)];

        /**
         __NSSingleObjectArrayI 数组只有一个元素
         __NSArray0 数组为空
         iOS11 after [__NSArrayI objectAtIndexedSubscript]
         iOS11 before [__NSArrayI objectAtIndexed]
         */
    });
}

- (instancetype)zc_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    BOOL hasNilObject = NO;
    
    for (NSUInteger i = 0; i < cnt; i ++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"%@", objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
            NSLog(@"%s object at index %lu is nil, it will be filtered", __FUNCTION__, i);
        }
    }
    
    // 因为有值为nil的元素，可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index ++] = objects[i];
            }
        }
        return [self zc_initWithObjects:newObjects count:index];
    }
    return [self zc_initWithObjects:objects count:cnt];
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

// *** -[__NSArray0 objectAtIndex:]: index 3 beyond bounds for empty NSArray 数组为空
- (id)zc_objectAtIndex:(NSUInteger)index {
    if (index > self.count - 1 || self.count == 0) {
        @try {
            return [self zc_objectAtIndex:index];
        } @catch (NSException *exception) {
//            NSLog(@"callStackSymbols：%@", [exception callStackSymbols]);
//            NSLog(@"exception.reason：%@", exception.reason);
            [CrashLog zc_errorWithException:exception];

            return nil;
        } @finally {
            // Code that gets executed whether or not an exception is thrown
            // 这部分的代码不论是否抛出异常都会执行的代码，即使你在前面的代码块中使用了return，这部分也会执行
            // 这里一般做一些清理善后工作，比如保存一些数据，错误信息，清理一些数据等
        }
    } else {
        return [self zc_objectAtIndex:index];
    }
}

// *** -[__NSSingleObjectArrayI objectAtIndex:]: index 3 beyond bounds [0 .. 0]' 数组只有一个元素
- (id)zc_singleObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self zc_singleObjectAtIndex:index];
    } @catch (NSException *exception) {
//        NSLog(@"callStackSymbols：%@", [exception callStackSymbols]);
//        NSLog(@"exception.reason：%@", exception.reason);
        [CrashLog zc_errorWithException:exception];

    } @finally {
        return object;
    }
}


@end
