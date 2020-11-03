//
//  QXMultiScrollHeader.h
//  AwesomeCBS
//
//  Created by coderQXGuo on 2019/3/4.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#ifndef QXMultiScrollHeader_h
#define QXMultiScrollHeader_h

#import "QXMultiScrollPageCtrl.h"
#import "QXMultiScrollSegmentedPageCtrl.h"
#import "QXMultiScrollBaseTable.h"

#define QXMS_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define QXMS_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define QXMS_STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define QXMS_IS_IPAD ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define QXMS_NAVIGATION_BAR_HEIGHT ((QXMS_IS_IPAD ? 50 : 44) + QXMS_STATUS_BAR_HEIGHT)
#define QXMS_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define QXMS_ONE_PIXEL (1 / [UIScreen mainScreen].scale)

static const CGFloat QXMSSegmentHeight = 44.0;

#endif /* QXMultiScrollHeader_h */
