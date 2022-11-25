//
//  ZCTest.h
//  30-copyIvarList+copyPropertyList
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCTest : NSObject
{
    NSString *_name;
    NSString *_userName;
}

@property (nonatomic, copy) NSString *age;

@end

NS_ASSUME_NONNULL_END
