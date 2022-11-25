//
//  CrashLog.h
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CrashLog : NSObject

+ (void)zc_errorWithException:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
