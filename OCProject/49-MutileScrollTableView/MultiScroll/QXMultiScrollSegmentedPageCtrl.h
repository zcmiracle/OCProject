//
//  QXMultiScrollSegmentedPageCtrl.h
//  AwesomeCBS
//
//  Created by coderQXGuo on 2019/3/4.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QXMultiScrollPageCtrl;
@protocol QXMultiScrollSegmentedPageCtrlDelegate <NSObject>
@optional
- (void)segmentedPageViewControllerWillBeginDragging;
- (void)segmentedPageViewControllerDidEndDragging;
- (void)segmentedPageViewControllerDidEndDeceleratingWithPageIndex:(NSInteger)index;
@end

@interface QXMultiScrollSegmentedPageCtrl : UIViewController
@property (nonatomic, copy) NSArray<QXMultiScrollPageCtrl *> *pageViewControllers;
@property (nonatomic, strong, readonly) QXMultiScrollPageCtrl  *currentPageViewController;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (assign, nonatomic) NSInteger originalIndex;
@property (nonatomic, weak) id<QXMultiScrollSegmentedPageCtrlDelegate> delegate;

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

@end

