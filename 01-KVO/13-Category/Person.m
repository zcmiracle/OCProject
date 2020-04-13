
//
//  Person.m
//  13-Category
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Person.h"

@interface Person ()

// 类扩展声明的私有方法，如果在分类的 .h 中暴露出来 私有方法前向引用
- (void)ExtensionPrivateMethod ;

@end

@implementation Person

//- (void)test {
//    NSLog(@"%s", __func__);
//}

- (void)ExtensionPrivateMethod {
    NSLog(@"类扩展@interface()有声明，私有方法");
}

- (void)noInterfacePrivateMethod {
    NSLog(@"没有在类扩展@interface()中声明的私有方法");
}

@end
