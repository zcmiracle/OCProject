//
//  main.m
//  18-Runtime实现weak
//
//  Created by Fearless on 2020/3/24.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // Runtime如何实现weak属性？Runtime如何实现weak变量的自动置为nil
        // objc-weak.h 文件
        /**
         1、添加弱引用：weak_register_no_lock
         2、移除一个弱引用：weak_unregister_no_lock
         3、指定对象是否存在弱引用：weak_is_registered_no_lock   只是一个判断
         4、清除指定对象所有弱引用：weak_clear_no_lock
         
                全局哈希表 SideTables
         key：对象的指针地址
         通过key从SideTables中找到SideTable，
         SideTable:
            自旋锁spinLock
            引用计数表RefCountMap
            弱引用表weak_table
                结构体weak_table_t
                数组大小num_entries
                数组 weak_entries
                    结构体weak_entry_t
                    被引用对象referent
                    引用数组referrers
                    引用数组inline_referrers（大小为4）
         
         weak自动nil：
         1、首先执行clearDeallocating方法
         2、再次调用objc-weak.h 文件中的weak_clear_no_lock方法
         
         总结：
         1、当一个对象有弱引用时，会封装成一个结构体weak_entry_t
         将其放入一个数组中weak_entries，并根据该对象的地址作为标识
         2、当该对象的引用计数为0时，会以其地址为标识遍历搜索数组，
         把指向该对象的所有指针都置为nil
            解释：当引用计数为0时候，会根据地址值找到weak_entry_t，
            然后找到referrers数组，然后遍历，将指向该对象的所有指针置为nil
         
         */
        
        NSObject *obj = [[NSObject alloc] init];
        __weak NSObject *weakObj = obj;
        
        // 调用objc_initWeak(参数1, 参数2)
        // 参数1：weakObj --> 弱引用指针
        // 参数2：obj     --> 弱引用对象
        // 调用objc_storeWeak()
        // objc_register_no_lock()
        // 包装成一个结构体对象，将其放入数组中
     
        
        /**
         weak_register_no_lock
         weak_is_registered_no_lock
         weak_clear_no_lock
         weak_unregister_no_lock
         
         */
        
    }
    return 0;
}

#if 0

struct SideTable {
    spinlock_t slock;           // 自旋锁【保证原子操作的自旋锁】
    RefcountMap refcnts;        // 引用计数hash表 哈希查找提高查找效率
    weak_table_t weak_table;    // 弱引用表 weak 引用全局hash表
};


 struct weak_table_t {
    weak_entry_t *weak_entries;         // 保存了所有指向指定对象的 weak 指针  数组
    size_t    num_entries;              // 存储空间
    uintptr_t mask;                     // 参与判断引用计数辅助量
    uintptr_t max_hash_displacement;    // hash key 最大偏移值
};
 

struct weak_entry_t {
    // 泛型类来解决内存泄漏问题
    DisguisedPtr<objc_object> referent; // 被引用对象referent
    // 共用体 union
    union {
        struct {
            weak_referrer_t *referrers; // 引用数组referrers 当前对象的所有弱引用指针
            uintptr_t        out_of_line_ness : 2;  // 最低有效位
            uintptr_t        num_refs : PTR_MINUS_2;// 引用数值
            uintptr_t        mask;                  // 计数辅助量
            uintptr_t        max_hash_displacement; // hash元素上线阀值
        };
        struct {
            // out_of_line_ness field is low bits of inline_referrers[1]
            // 引用数组大小为4
            weak_referrer_t  inline_referrers[WEAK_INLINE_COUNT];
        };
    };

    // 构造函数？？？
    weak_entry_t(objc_object *newReferent, objc_object **newReferrer)
        : referent(newReferent) {
        // 第0个位置放了弱引用变量，后面位置置为nil
        inline_referrers[0] = newReferrer;
        for (int i = 1; i < WEAK_INLINE_COUNT; i++) {
            inline_referrers[i] = nil;
        }
    }
};



#endif

