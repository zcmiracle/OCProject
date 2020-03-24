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
         SideTable: 自旋锁spinLock + 引用计数表RefCountMap + 弱引用表weak_table
         弱引用表：结构体weak_table_t + 数组 weak_entries + 数组大小num_entries
         
         weak_entries： 结构体weak_entry_t + 被引用对象referent + 引用数组referrers + 引用数组inline_referrers（大小为4）
         
         */
        
    }
    return 0;
}
