//
//  AppDelegate.m
//  24-页面跳转
//
//  Created by Fearless on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.


    
    return YES;
}

#if 0

   // 创建class：
   objc_allocateClassPair(Class  _Nullable __unsafe_unretained superclass, const char * _Nonnull name, size_t extraBytes)

   // 注册class
   objc_registerClassPair(Class  _Nonnull __unsafe_unretained cls)
   
   // 添加变量
   class_addIvar(Class  _Nullable __unsafe_unretained cls, const char * _Nonnull name, size_t size, uint8_t alignment, const char * _Nullable types)
    
   // 添加方法
   class_addMethod(Class  _Nullable __unsafe_unretained cls, SEL  _Nonnull name, IMP  _Nonnull imp, const char * _Nullable types)
    
    // 获取属性
    class_getProperty(Class  _Nullable __unsafe_unretained cls, const char * _Nonnull name)

    // 获取成员变量 实例变量
    class_getInstanceVariable(Class  _Nullable __unsafe_unretained cls, const char * _Nonnull name)

#endif


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
