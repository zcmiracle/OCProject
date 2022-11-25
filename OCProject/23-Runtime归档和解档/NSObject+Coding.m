//
//  NSObject+Coding.m
//  23-Runtime归档和解档
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "NSObject+Coding.h"
#import <objc/runtime.h>

@implementation NSObject (Coding)

// 解档
- (void)zc_encode:(NSCoder *)encoder {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertyList[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        [encoder encodeObject:[self valueForKey:propertyName] forKey:propertyName];
    }
}

// 归档
- (void)zc_decode:(NSCoder *)decoder {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertyList[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id value = [decoder decodeObjectForKey:propertyName];
        [self setValue:value forKey:propertyName];
    }
}

@end
