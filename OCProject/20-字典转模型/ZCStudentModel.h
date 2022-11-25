//
//  ZCStudentModel.h
//  20-字典转模型
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCStudentModel : ZCBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

@end

NS_ASSUME_NONNULL_END
