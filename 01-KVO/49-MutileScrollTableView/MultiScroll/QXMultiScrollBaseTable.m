//
//  QXMultiScrollBaseTable.m
//  AwesomeCBS
//
//  Created by coderQXGuo on 2019/3/4.
//  Copyright © 2019年 Facebook. All rights reserved.
//
#import "QXMultiScrollHeader.h"

@implementation QXMultiScrollBaseTable
// 是否让手势透传到子视图
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    CGFloat segmentViewContentScrollViewHeight = QXMS_SCREEN_HEIGHT - QXMS_NAVIGATION_BAR_HEIGHT - self.categoryViewHeight ?: QXMSSegmentHeight;
    CGPoint currentPoint = [gestureRecognizer locationInView:self];
    if (CGRectContainsPoint(CGRectMake(0, self.contentSize.height - segmentViewContentScrollViewHeight, QXMS_SCREEN_WIDTH, segmentViewContentScrollViewHeight), currentPoint)) {
        return YES;
    }
    return NO;
}

@end
