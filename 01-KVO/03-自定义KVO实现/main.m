//
//  main.m
//  03-自定义KVO实现
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RuntimeKit.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

    
    }
    return 0;
}


/**
 主要方法：
 添加通知：
 zc_addObserver...
 
 监听通知：
 zc_observerValueForKey
 
 删除通知：
 zc_removeObserver

 核心工作：
 1、修改isa
 2、添加修改后的setter方法
 3、添加修改后的class方法
 4、通知外界
 
 
 
 */
