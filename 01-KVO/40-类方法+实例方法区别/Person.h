//
//  Person.h
//  40-类方法+实例方法区别
//
//  Created by XFB on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

- (void)instanceMethod;
+ (void)classMethod;
    
@end

NS_ASSUME_NONNULL_END
