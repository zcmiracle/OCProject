//
//  NSObject+ZCKVO.h
//  03-自定义KVO实现
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCObserverInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZCKVO)

// 添加KVO
- (void)zc_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(ZCKeyValueObservingOptions)options;

// 监听KVO
- (void)zc_observeValueForKeyPath:(NSString *)keyPath
                         ofObject:(id)object
                           change:(NSDictionary<NSKeyValueChangeKey,id> *)change;

// 删除KVO
- (void)zc_removeObserver:(NSObject *)observer
               forKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
