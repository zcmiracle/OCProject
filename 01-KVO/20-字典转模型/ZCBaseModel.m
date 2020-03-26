//
//  ZCBaseModel.m
//  20-字典转模型
//
//  Created by Fearless on 2020/3/25.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ZCBaseModel.h"
#import <objc/runtime.h>

@implementation ZCBaseModel

- (id)initWithDataDict:(NSDictionary *)data {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        objc_property_t *propertyList = class_copyPropertyList([self class], &count);
        // 遍历属性，找到字典中的value赋值给属性
        for (int i = 0; i < count; i ++) {
            // 获取属性
            objc_property_t property = propertyList[i];
            
            // 获取属性名
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            
            id value = [data objectForKey:propertyName];

            if ([value isKindOfClass:[NSNumber class]]) {
                // 判断是否NSNumber 转成 NSString 用 stringValue
                [self setValue:[value stringValue] forKey:propertyName];
            } else if ([value isKindOfClass:[NSNull class]]) {
                // 判断是否为空，转成空字符串
            } else if ([value isKindOfClass:[NSDictionary class]]) {
                // 当字典中的value是字典时，属性为另一个model时
                NSString *clsName = [NSString stringWithUTF8String:property_getAttributes(property)];
                clsName = [clsName substringFromIndex:3];
                clsName = [clsName substringToIndex:[clsName rangeOfString:@"\""].location];
                Class modelClass = NSClassFromString(clsName);
                if (modelClass) {
                    [self setValue:[[modelClass alloc] initWithDataDict:value] forKey:propertyName];
                }
            } else if ([value isKindOfClass:[NSArray class]]) {
                // 当字典中value为数组时，属性为一个model数组时
                if ([self respondsToSelector:@selector(modelClassInPropertyArray:)]) {
                    NSString *className = [self modelClassInPropertyArray:propertyName];
                    Class modelClass = NSClassFromString(className);
                    NSMutableArray *modelArray = [NSMutableArray array];
                    for (NSDictionary *dictionary in value) {
                        id model = [[modelClass alloc] initWithDataDict:dictionary];
                        [modelArray addObject:model];
                    }
                    [self setValue:modelArray forKey:propertyName];
                }
            } else {
                [self setValue:value forKey:propertyName];
            }
        }
        free(propertyList);
    }
    return self;
}

@end
