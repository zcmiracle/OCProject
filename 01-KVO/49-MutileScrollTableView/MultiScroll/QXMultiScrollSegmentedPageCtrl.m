//
//  QXMultiScrollSegmentedPageCtrl.h
//  AwesomeCBS
//
//  Created by coderQXGuo on 2019/3/4.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import "QXMultiScrollHeader.h"

#define kWidth self.view.frame.size.width

@interface QXMultiScrollSegmentedPageCtrl () <UIScrollViewDelegate>
@property (nonatomic, strong, readwrite) UIScrollView *scrollView;
@property (nonatomic, strong) QXMultiScrollPageCtrl *currentPageViewController;
@end

@implementation QXMultiScrollSegmentedPageCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.currentPageViewController = self.pageViewControllers[self.originalIndex];
    _selectedIndex = self.originalIndex;
    
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, 0, QXMS_SCREEN_WIDTH, QXMS_SCREEN_HEIGHT - QXMS_NAVIGATION_BAR_HEIGHT - QXMSSegmentHeight);
    [self.pageViewControllers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *controller = obj;
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        controller.view.frame = CGRectMake(idx * QXMS_SCREEN_WIDTH, 0, QXMS_SCREEN_WIDTH, self.scrollView.bounds.size.height);
    }];
}

#pragma mark - Setters
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self.scrollView setContentOffset:CGPointMake(QXMS_SCREEN_WIDTH * selectedIndex, 0) animated:YES];
    self.currentPageViewController = self.pageViewControllers[selectedIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedPageViewControllerWillBeginDragging)]) {
        [self.delegate segmentedPageViewControllerWillBeginDragging];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedPageViewControllerDidEndDragging)]) {
        [self.delegate segmentedPageViewControllerDidEndDragging];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = (NSUInteger)(self.scrollView.contentOffset.x / kWidth);
    self.currentPageViewController = self.pageViewControllers[index];
    _selectedIndex = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedPageViewControllerDidEndDeceleratingWithPageIndex:)]) {
        [self.delegate segmentedPageViewControllerDidEndDeceleratingWithPageIndex:index];
    }
}

#pragma mark - Getters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.contentSize = CGSizeMake(kWidth * self.pageViewControllers.count, 0);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        [_scrollView.panGestureRecognizer requireGestureRecognizerToFail: [NXNavigate getRootNavigationCtrl].topViewController.navigationController.interactivePopGestureRecognizer];
    }
    return _scrollView;
}

@end
