//
//  Test.h
//  08-Block循环引用
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TestBlock)(void);

@interface Test : NSObject

@property (nonatomic, copy) TestBlock testBlock;
@property (nonatomic, copy) NSString *name;

- (void)weakMethod;
- (void)blockMethod;

@end

NS_ASSUME_NONNULL_END
