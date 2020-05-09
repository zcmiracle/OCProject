//
//  NSObject+Swizzled.h
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzled)

/// 交换实例对象方法
/// @param originalSEL 原始方法SEL
/// @param swizzledSEL 类方法SEL
+ (BOOL)swizzleInstanceObjMethod:(SEL)originalSEL swizzledSEL:(SEL)swizzledSEL;

@end

NS_ASSUME_NONNULL_END
