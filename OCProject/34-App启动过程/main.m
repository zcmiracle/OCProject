//
//  main.m
//  34-App启动过程
//
//  Created by Fearless on 2020/4/4.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCAppDelegate.h"
#import "ZCApplication.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([ZCAppDelegate class]);
    }
    
    // 创建应用程序对象和应用程序委托，并设置事件周期。
    return UIApplicationMain(argc, argv, @"ZCApplication", appDelegateClassName);
    
}


#if 0


// If nil is specified for principalClassName, the value for NSPrincipalClass from the Info.plist is used. If there is no
// NSPrincipalClass key specified, the UIApplication class is used. The delegate class will be instantiated using init.
UIApplicationMain(int argc,
                  char * _Nullable argv[_Nonnull],
                  NSString * _Nullable principalClassName,
                  NSString * _Nullable delegateClassName);

argc
命令行参数个数，argv中的参数计数;这通常是与main相对应的参数。

argv
参数的可变列表;这通常是与main相对应的参数。

principalClassName
UIApplication类或子类的名称。如果你指定nil, UIApplication是假定的。

delegateClassName
实例化应用程序委托的类的名称。如果principalClassName指定了UIApplication的一个子类，你可以指定这个子类为委托;子类实例接收应用程序委托消息。
如果从应用程序的主nib文件加载委托对象，则指定nil


Discussion
此函数从主体类实例化应用程序对象，并从给定类实例化委托(如果有)，并为应用程序设置委托。
它还设置主事件循环，包括应用程序的运行循环，并开始处理事件。如果应用程序的信息。
plist文件指定要加载的主nib文件，该函数通过包含NSMainNibFile键和一个有效的nib文件名来加载该nib文件。
尽管声明了返回类型，但该函数从不返回。

runloop伪代码
do {
    1、处理事件
    2、if (判断是否与其他消息需要处理，如果有) {
        goto:handle_msg(处理消息模块)
    }
    3、等待消息（wait）即睡眠
    
    __CFRunLoopServiceMachPort(wait) 准备睡眠阻塞
    // 如果有消息来了，需要处理，就醒来
    // mach_msg(port)
    
    4、醒来了（即有消息来了） Observer(kCFRunLoopAfterWaiting)
    
    5、继续处理消息：handle_msg:(处理消息模块)
} while(1)




#endif
