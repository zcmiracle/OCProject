//
//  UserModel.m
//  23-Runtime归档和解档
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "UserModel.h"
#import "NSObject+Coding.h"
#import "ZCCoding.h"

@implementation UserModel
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [self zc_encode:aCoder];
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (self) {
//        [self zc_decode:aDecoder];
//    }
//    return self;
//}

//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.personID forKey:@"personID"];
//    [aCoder encodeObject:self.name forKey:@"name"];
//    [aCoder encodeObject:self.age forKey:@"age"];
//    [aCoder encodeObject:self.money forKey:@"money"];
//    [aCoder encodeObject:self.height forKey:@"height"];
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (self) {
//        self.personID = [aDecoder decodeObjectForKey:@"personID"];
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//        self.age = [aDecoder decodeObjectForKey:@"age"];
//        self.money = [aDecoder decodeObjectForKey:@"money"];
//        self.height = [aDecoder decodeObjectForKey:@"height"];
//    }
//    return self;
//}
ZCAutoCoding
@end
