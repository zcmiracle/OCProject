//
//  NSObject+Swizzling.h
//  19-Method-Swizzling
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

+ (void)swizzleMethod:(SEL)originalSEL withMethod:(SEL)swizzledSEL;

@end

NS_ASSUME_NONNULL_END
