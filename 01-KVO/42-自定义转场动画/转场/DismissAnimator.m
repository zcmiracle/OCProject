//
//  DismissAnimator.m
//  42-自定义转场动画
//
//  Created by Fearless on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "DismissAnimator.h"

@implementation DismissAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;

    // 获取到toView：从vcB dissmiss fromView是B toView是A
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    CGRect finalFrame = CGRectOffset(fromView.frame, 0.f, [UIScreen mainScreen].bounds.size.height);

    [containerView addSubview:toView];
    [containerView bringSubviewToFront:fromView];
    
    [UIView animateWithDuration:2.0f animations:^{
        fromView.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];  //它肯定实现了移除fromView的操作
    }];
    
}


@end
