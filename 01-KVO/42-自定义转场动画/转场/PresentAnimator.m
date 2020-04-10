//
//  PresentAnimator.m
//  42-自定义转场动画
//
//  Created by Fearless on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "PresentAnimator.h"

@implementation PresentAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.0f;
}
 
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 获取容器view
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [containerView addSubview:toView];
    
    CGRect frame = CGRectOffset(toView.frame, 0.0f, [UIScreen mainScreen].bounds.size.height);
    toView.frame = frame;
    
    [UIView animateWithDuration:2.0f animations:^{
        toView.frame = CGRectOffset(toView.frame, 0.0f, -[UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


@end
