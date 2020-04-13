//
//  Person+Category1.m
//  13-Category
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Person+Category1.h"

@implementation Person (Category1)

- (void)noInterfaceCategoryPrivateMethod {
    NSLog(@"没有在类扩展@interface()中声明，并且在Category的私有方法");
}

- (void)test {
    NSLog(@"%s", __func__);
}

@end
