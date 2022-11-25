//
//  Person+Category.h
//  14-Category关联对象
//
//  Created by Fearless on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Category)

@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
