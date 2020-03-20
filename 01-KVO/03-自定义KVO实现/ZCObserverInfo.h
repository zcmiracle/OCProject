//
//  ZCObserverInfo.h
//  03-自定义KVO实现
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, ZCKeyValueObservingOptions) {
    ZCKeyValueObservingOptionsNew = 0x01,
    ZCKeyValueObservingOptionsOld = 0x02
};

NS_ASSUME_NONNULL_BEGIN

@interface ZCObserverInfo : NSObject

// 监听者
@property (nonatomic, strong) id observer;
// 被监听的key
@property (nonatomic, copy) NSString *key;
// 监听策略
@property (nonatomic, assign) ZCKeyValueObservingOptions options;

- (instancetype)initWithObserver:(id)observer
                             Key:(NSString *)key
                         options:(ZCKeyValueObservingOptions)options;


@end

NS_ASSUME_NONNULL_END
