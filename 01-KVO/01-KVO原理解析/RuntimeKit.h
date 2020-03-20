//
//  RuntimeKit.h
//  01-KVO
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h> // 类相关函数
#import <objc/message.h> // 消息相关函数

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeKit : NSObject

// 1、根据类名获取类
+ (Class)fetchClass:(NSString *)className;
// 2、根据类获取类名
+ (NSString *)fectchClassName:(Class)cls;
// 3、获取成员变量
+ (NSArray *)fetchIvarList:(Class)cls;
// 4、获取成员属性
+ (NSArray *)fetchPropertyList:(Class)cls;
// 5、获取类的实例方法
+ (NSArray *)fetchMethodList:(Class)cls;
// 6、获取协议列表
+ (NSArray *)fetchProtocolList:(Class)cls;
// 7、动态添加方法
+ (void)addMethod:(Class)cls1
       methodName:(SEL)method1
      methodClass:(Class)cls2
        methodImp:(SEL)method2;
// 8、动态交换方法
+ (void)exchangeMethod:(Class)cls
           firstMethod:(SEL)method1
          secondMethod:(SEL)method2;

@end

NS_ASSUME_NONNULL_END
