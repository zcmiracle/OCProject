//
//  AppDelegate.m
//  34-App启动过程
//
//  Created by Fearless on 2020/4/4.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Config.h"
#import "AppDelegate+Location.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#if 0
1、App启动入口main函数
2、UIApplicationMain作用 AppDelegate
3、Runloop作用
4、infoPlist 加载nib文件
5、UIWindow
6、AppDelegate业务
7、启动时间优化(main函数前 + main函数后)

T1：系统环境布局时间：创建进程，加载解析可执行文件（库加载、堆栈环境配置等等）
T2：从main到第一个界面显示时间

1、库加载越多，启动越慢
2、Objc类越多，越慢
3、静态对象全局对象越多，启动越慢
4、Objc的 + load()越多，启动越慢

更新把控的：+load() 和 T2时间上进行优化


#endif


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    // 根据业务拆分
    
    // 百度地图定位配置
    [self locationConfig];
    
    // 友盟等第三方配置
    [self umengConfig];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
