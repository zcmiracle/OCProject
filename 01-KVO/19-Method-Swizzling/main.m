//
//  main.m
//  19-Method-Swizzling
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//  Method-Swizzling 处理数组越界

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"
#import "NSArray+SafeCategory.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // 方法交换
        NSArray *array = @[@"1", @"2"];
        NSMutableArray *mutableArray = [NSMutableArray arrayWithObject:@"1"];
        NSDictionary *dictionary = @{@"name": @"Fearless"};
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithObject:@"Miracle" forKey:@"name"];
        Class isa1 = object_getClass(array);                // __NSArrayI
        Class isa2 = object_getClass(mutableArray);         // __NSArrayM
        Class isa3 = object_getClass(dictionary);           // __NSSingleEntryDictionaryI
        Class isa4 = object_getClass(mutableDictionary);    // __NSDictionaryM

        NSLog(@"%@", [array objectAtIndex:3]);

        /**
                                isa
         NSArray                           __NSArrayI
         NSMutableArray              __NSArrayM
         NSDictionary                   __NSDictionaryI
         NSMutableDictionary      __NSDictionaryM
         */
    }
    return 0;
}


#if 0

// 交换方法
method_exchangeImplementations(<#Method  _Nonnull m1#>, <#Method  _Nonnull m2#>)


// 获取method
class_getInstanceMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>)
Method class_getInstanceMethod(Class cls, SEL sel) {
    if (!cls  ||  !sel) return nil;
    // 查询方法列表 返回IMP
    lookUpImpOrNil(cls, sel, nil,
                   NO/*initialize*/, NO/*cache*/, YES/*resolver*/);
    // _class_getMethod 先从当前类
    return _class_getMethod(cls, sel);
}

static Method _class_getMethod(Class cls, SEL sel) {
    rwlock_reader_t lock(runtimeLock);
    return getMethod_nolock(cls, sel);
}

static method_t *getMethod_nolock(Class cls, SEL sel) {
    method_t *m = nil;
    runtimeLock.assertLocked();
    assert(cls->isRealized());
    // 先从当前类 然后往父类的父类   所以交换方法可能是交换父类的方法，如果子类没有这个方法的话
    // 所以一般都是先添加方法，然后交换方法
    // 如果已有方法的话，添加方法会失败，只有在方法没有添加的时候添加方法才会成功
    // 如果子类没有实现方法，父类实现了，给子类添加方法会成功，如果子类实现了，添加失败。然后交换的还是子类的方法，不会影响父类的方法
    while (cls  &&  ((m = getMethodNoSuper_nolock(cls, sel))) == nil) {
        cls = cls->superclass;
    }
    return m;
}

static method_t * getMethodNoSuper_nolock(Class cls, SEL sel) {
    runtimeLock.assertLocked();
    assert(cls->isRealized());
    // 方法列表中遍历查找 cls->data() class_rw_t
    for (auto mlists = cls->data()->methods.beginLists(),
              end = cls->data()->methods.endLists();
         mlists != end;
         ++mlists) {
        method_t *m = search_method_list(*mlists, sel);
        if (m) return m;
    }
    return nil;
}


// 添加方法
class_addMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)

#endif
