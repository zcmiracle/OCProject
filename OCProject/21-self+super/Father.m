//
//  Father.m
//  21-self+super
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Father.h"

@implementation Father

- (void)run {
    NSLog(@"%s", __func__);
}

- (Class)class {
//    NSLog(@"调用了Father的class方法!");
    return [super class];
    
    /**
     打印self还是son
     Printing description of self:
     <Son: 0x1020614f0>
     2020-03-26 10:00:54.744663+0800 21-self+super[1866:160693] 调用了Father的class方法!
     */
}

@end
