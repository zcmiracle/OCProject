//
//  InteractiveTransition.m
//  42-自定义转场动画
//
//  Created by XFB on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "InteractiveTransition.h"

@interface InteractiveTransition () {
    UIViewController *presentedViewController;
    BOOL shouldCompletion;
}

@end

@implementation InteractiveTransition

- (void)transitionToViewController:(UIViewController *)toViewController {
    presentedViewController = toViewController;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [toViewController.view addGestureRecognizer:panGesture];
}

- (void)panAction:(UIPanGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.isInteractive = YES;
            [presentedViewController dismissViewControllerAnimated:YES completion:nil];
            break;
            
        case UIGestureRecognizerStateChanged: {
            // 监听当前滑动的距离
            CGPoint transitionPoint = [gesture translationInView:presentedViewController.view];
            NSLog(@"transitionPoint %@", NSStringFromCGPoint(transitionPoint));
            
            CGFloat ration = transitionPoint.y / [UIScreen mainScreen].bounds.size.height;
            if (ration >= 0.5) {
                shouldCompletion = YES;
            } else {
                shouldCompletion = NO;
            }
            [self updateInteractiveTransition:ration];
        }
            break;
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateCancelled: {
            if (shouldCompletion) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            self.isInteractive = NO;
        }
        default:
            break;
    }
}


@end
