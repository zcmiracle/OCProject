//
//  ZCObserver.m
//  04-KVC赋值
//
//  Created by XFB on 2020/3/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ZCObserver.h"

@implementation ZCObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change：%@", change);
}

@end
