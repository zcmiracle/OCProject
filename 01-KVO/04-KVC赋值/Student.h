//
//  Student.h
//  04-KVC赋值
//
//  Created by XFB on 2020/3/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
{
//    NSString *_name;    // 1
//    NSString *_isName;  // 2
//    NSString *name;     // 3
    NSString *isName;   // 4
}

//@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
