//
//  Person.h
//  10-Block拷贝MRC
//
//  Created by XFB on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TestBlock)(void);

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) TestBlock testBlock;

- (void)method;

@end

NS_ASSUME_NONNULL_END
