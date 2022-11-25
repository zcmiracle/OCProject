//
//  WeakTimerObject.h
//  27-定时器
//
//  Created by Fearless on 2020/3/28.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakTimerObject : NSObject

@property (nonatomic, weak) id target;

+ (instancetype)zcWeakTimerObjectWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
