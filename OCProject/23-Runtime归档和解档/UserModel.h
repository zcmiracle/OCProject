//
//  UserModel.h
//  23-Runtime归档和解档
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *personID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *height;

@end

NS_ASSUME_NONNULL_END
