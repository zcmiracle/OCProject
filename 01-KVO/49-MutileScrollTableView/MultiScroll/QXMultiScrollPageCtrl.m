//
//  QXMultiScrollPageCtrl.h
//  AwesomeCBS
//
//  Created by coderQXGuo on 2019/3/4.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import "QXMultiScrollPageCtrl.h"

@interface QXMultiScrollPageCtrl () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic) BOOL canScroll;
@property (assign, nonatomic) CGFloat lastOffsetY;
/** <#property#> */
@property (assign, nonatomic) CGFloat maxOffSetY;

@end

@implementation QXMultiScrollPageCtrl

#pragma mark - Private Methods
- (instancetype)init {
    if (self = [super init]) {
        self.maxOffSetY = -1;
    }
    return self;
}

- (void)makePageViewControllerScroll:(BOOL)canScroll {
    self.canScroll = canScroll;
    self.scrollView.showsVerticalScrollIndicator = canScroll;
    if (!canScroll) {
        self.scrollView.contentOffset = CGPointZero;
    }
}

- (void)makePageViewControllerScrollToTop{
    [self.scrollView setContentOffset:CGPointZero];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollView = scrollView;
    
    if (self.canScroll) {
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY <= 0) {
            [self makePageViewControllerScroll:NO];
            if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewControllerLeaveTop)]) {
                [self.delegate pageViewControllerLeaveTop];
            }
        }
    } else {
        [self makePageViewControllerScroll:NO];
    }
    
    if (scrollView.contentSize.height - scrollView.contentOffset.y - self.maxOffSetY > 0) {
        BOOL isUping = self.lastOffsetY - scrollView.contentOffset.y > 0;
        if ([self.delegate respondsToSelector:@selector(pageViewController:ScrollDirectionDidChange:)]) {
            [self.delegate pageViewController:self ScrollDirectionDidChange:isUping];
        }
        
        self.lastOffsetY = MIN(scrollView.contentOffset.y, scrollView.contentSize.height);
    }
}

- (CGFloat)maxOffSetY {
    if (_maxOffSetY == -1 ) {
        if (@available(iOS 11.0, *)) {
            _maxOffSetY = _scrollView.bounds.size.height - [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
        } else {
            _maxOffSetY = _scrollView.bounds.size.height;
        }
    }
    return _maxOffSetY;
}

@end
