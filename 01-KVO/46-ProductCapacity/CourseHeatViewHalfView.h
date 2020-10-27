//
//  CourseHeatViewHalfView.h
//  46-ProductCapacity
//
//  Created by Fearless on 2020/10/27.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface CourseHeatViewHalfView : UIView

// 课程热度数组数据
@property (nonatomic, strong) NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
