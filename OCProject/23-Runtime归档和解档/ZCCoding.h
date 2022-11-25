//
//  ZCCoding.h
//  01-KVO
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <objc/runtime.h>
#ifndef ZCCoding_h
#define ZCCoding_h
#define ZCAutoCoding \
- (void)encodeWithCoder:(NSCoder *)aCoder {\
    unsigned int count = 0;\
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);\
    for (int i = 0; i < count; i ++) {\
        objc_property_t property = propertyList[i];\
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];\
        [aCoder encodeObject:[self valueForKey:propertyName] forKey:propertyName];\
    }\
}\
- (instancetype)initWithCoder:(NSCoder *)aDecoder {\
    self = [super init];\
    if (self) {\
        unsigned int count = 0;\
        objc_property_t *propertyList = class_copyPropertyList([self class], &count);\
        for (int i = 0; i < count; i ++) {\
            objc_property_t property = propertyList[i];\
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];\
            id value = [aDecoder decodeObjectForKey:propertyName];\
            [self setValue:value forKey:propertyName];\
        }\
    }\
    return self;\
}\

#endif /* ZCCoding_h */
