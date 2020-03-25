//
//  ZCBaseModel.h
//  20-字典转模型
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCBaseModel : NSObject

- (void)initWithDataDict:(NSDictionary *)data;
- (NSString *)modelClassInPropertyArray:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
