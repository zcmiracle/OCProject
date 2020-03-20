//
//  Person.h
//  02-手动调用KVO
//
//  Created by XFB on 2020/3/20.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

- (void)setPersonInfo:(NSDictionary *)personInfo;

@end

NS_ASSUME_NONNULL_END
