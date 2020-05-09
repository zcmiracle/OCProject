//
//  CrashLog.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "CrashLog.h"

@implementation CrashLog

+ (void)zc_errorWithException:(NSException *)exception {
    
    // 堆栈信息
    NSArray *callStackSymbolsArray = [NSThread callStackSymbols];
    NSString *mainCallStackSymbolMessage = [self getMainCallStackSymbolMessageWith:callStackSymbolsArray[2]];
        
    NSLog(@"===================【奔溃信息--开始】===================");
    NSLog(@"[Crash Type]：%@", exception.name);
    NSLog(@"[Crash Reason]：%@", exception.reason);
    NSLog(@"[Crash Place]：%@", mainCallStackSymbolMessage);
    NSLog(@"===================【奔溃信息--结束】===================\n\n\n");

    // 写入数据库
        
}

+ (NSString *)getMainCallStackSymbolMessageWith:(NSString *)callStackSymbolString {
   
    __block NSString *mainCallStackSymbolMessage = nil;
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];

    // 会产生copy所以用__block修饰 usingBlock且遍历的这种
    [regularExp enumerateMatchesInString:callStackSymbolString options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbolString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result) {
            mainCallStackSymbolMessage = [callStackSymbolString substringWithRange:result.range];
            *stop = YES;
        }
    }];
    return mainCallStackSymbolMessage;
}

@end
