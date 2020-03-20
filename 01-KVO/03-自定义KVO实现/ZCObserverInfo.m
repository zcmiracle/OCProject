//
//  ZCObserverInfo.m
//  03-自定义KVO实现
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//  保存观察者的信息

#import "ZCObserverInfo.h"

@class ZCObserverInfo;
@implementation ZCObserverInfo

- (instancetype)initWithObserver:(id)observer
                             Key:(NSString *)key
                         options:(ZCKeyValueObservingOptions)options {
    if (self = [super init]) {
        self.observer = observer;
        self.key = key;
        self.options = options;
    }
    return self;
}

@end
