//
//  SemaphoreLock.h
//  36-线程组
//
//  Created by XFB on 2020/4/7.
//  Copyright © 2020 XFB. All rights reserved.
//  信号量锁

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SemaphoreLock : NSObject

- (void)signalLock;

@end

NS_ASSUME_NONNULL_END
