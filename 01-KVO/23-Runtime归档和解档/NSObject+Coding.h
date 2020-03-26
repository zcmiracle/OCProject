//
//  NSObject+Coding.h
//  23-Runtime归档和解档
//
//  Created by XFB on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Coding)

- (void)zc_encode:(NSCoder *)encoder;
- (void)zc_decode:(NSCoder *)decoder;

@end

NS_ASSUME_NONNULL_END
