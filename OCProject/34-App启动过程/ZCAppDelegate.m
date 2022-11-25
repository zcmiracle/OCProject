//
//  ZCAppDelegate.m
//  34-App启动过程
//
//  Created by Fearless on 2020/4/5.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ZCAppDelegate.h"

@implementation ZCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // -[ZCAppDelegate application:didFinishLaunchingWithOptions:]
    NSLog(@"%s", __func__);
    
    // <ZCApplication: 0x7f830cc003d0>
    NSLog(@"%@", [UIApplication sharedApplication]);

    return YES;
}

@end
