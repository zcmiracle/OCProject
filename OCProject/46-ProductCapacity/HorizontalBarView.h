//
//  HorizontalBarView.h
//  46-ProductCapacity
//
//  Created by Fearless on 2020/10/27.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>
// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

NS_ASSUME_NONNULL_BEGIN

@interface HorizontalBarView : UIView

@property (nonatomic, strong) NSDictionary *dataDict;

@end

NS_ASSUME_NONNULL_END
