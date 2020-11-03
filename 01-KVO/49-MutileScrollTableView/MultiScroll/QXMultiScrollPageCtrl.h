//
//  QXMultiScrollPageCtrl.h
//  AwesomeCBS
//
//  Created by coderQXGuo on 2019/3/4.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QXMultiScrollPageCtrl;

@protocol QXMultiScrollPageCtrlDelegate <NSObject>

- (void)pageViewControllerLeaveTop;
- (void)pageViewController:(QXMultiScrollPageCtrl *)ctrl ScrollDirectionDidChange:(BOOL)isUping;

@end

@interface QXMultiScrollPageCtrl: UIViewController

@property (nonatomic, weak) id<QXMultiScrollPageCtrlDelegate> delegate;
/** 记录是上滑还是下滑 */
@property (assign, nonatomic) BOOL isUping;

- (void)makePageViewControllerScroll:(BOOL)canScroll;
- (void)makePageViewControllerScrollToTop;

@end
