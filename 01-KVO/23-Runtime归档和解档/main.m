//
//  main.m
//  23-Runtime归档和解档
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        UserModel *user = [[UserModel alloc] init];
        user.personID = @"123456";
        user.name = @"Fearless";
        user.age = @"28";
        user.money = @"84374734";
        user.height = @"172";
        NSLog(@"personID = %@, name = %@, age = %@, money = %@, height = %@", user.personID, user.name, user.age, user.money, user.height);
        
        // 归档
        NSString *file = [[NSBundle bundleWithPath:@"/Users/xfb/Desktop/"] pathForResource:@"UserModel" ofType:@"plist"];
        [NSKeyedArchiver archiveRootObject:user toFile:file];
        // 解档
        UserModel *userM = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
        NSLog(@"personID = %@, name = %@, age = %@, money = %@, height = %@", userM.personID, userM.name, userM.age, userM.money, userM.height);
        
        
    }
    return 0;
}


#if 0
// 获取属性列表
objc_property_t * class_copyPropertyList(<#Class  _Nullable __unsafe_unretained cls#>, <#unsigned int * _Nullable outCount#>)
// 获取属性名
const char *property_getName(<#objc_property_t  _Nonnull property#>)
// KVC设置
- (void)setValue:(id)value forKey:(NSString *)key
// KVC渎值
- (id)valueForKey:(NSString *)key
// 归档
- (void)encodeObject:(id)object forKey:(NSString *)key
// 解档
- (id)decodeObjectForKey:(NSString *)key
#endif

