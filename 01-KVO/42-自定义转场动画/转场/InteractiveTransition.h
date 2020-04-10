//
//  InteractiveTransition.h
//  42-自定义转场动画
//
//  Created by XFB on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isInteractive;

- (void)transitionToViewController:(UIViewController *)toViewController;

@end

NS_ASSUME_NONNULL_END
