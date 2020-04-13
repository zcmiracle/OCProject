//
//  Person+Category1.h
//  13-Category
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <AppKit/AppKit.h>


#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Category1)

// Person类中的类扩展声明的私有方法，想在其他类中使用，必须在Category中声明
- (void)ExtensionPrivateMethod;

- (void)test;

@end

NS_ASSUME_NONNULL_END
