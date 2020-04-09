//
//  动画笔记.h
//  01-KVO
//
//  Created by XFB on 2020/4/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#ifndef _____h
#define _____h

动画：


CAPropertyAnimation：属性动画（.keyPath）
    CABasicAnimation（.fromValue + .toValue）
    CAKeyFrameAnimation（.value + .path + .keyTimes）
CAAnimationGroup：动画组（.animations）
CATransition：过渡转场动画(.filter)


基础动画：只能从fromValue到toValue
    fromValue：相应属性的初始值
    toValue：相应属性的结束值
    随着动画的进行，在长度为duration的持续时间内，keyPath相应属性的值从fromValue渐渐地变为toValue
*** 如果fillMode = kCAFillModeForwards和removeOnCompletion = NO;
    那么动画执行完毕后，图层会保持显示动画执行后的状态，但是实质上，图层的属性还是动画执行前的初始值，
    并没有真正被改变，比如CALayer的position初始值为(0, 0)，CABasicAnimation的fromValue为(10, 10)
    toValue为(100, 100)，虽然动画执行完毕后图层保持在(100, 100)这个位置，实质上图层的position还是为(0, 0)

帧动画：有运动曲线

    核心动画
    动画组
    贝塞尔曲线
    转场动画


#endif /* _____h */
