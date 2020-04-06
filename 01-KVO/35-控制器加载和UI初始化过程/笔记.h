//
//  笔记.h
//  01-KVO
//
//  Created by Fearless on 2020/4/5.
//  Copyright © 2020 XFB. All rights reserved.
//

#ifndef ___h
#define ___h

1、层次关系 控制器、view、calayer
2、控制器初始化过程
3、C弱化
4、UI初始化过程
5、DeawRect(CALayer)
6、IB_DESIGNABLE IBInspectable


UIView 和 CALayer的关系
1、UIView管理CALayer
2、CALayer.delegate = UIView
CALayer 继承自NSObject，不能响应事件
UIView 继承自UIResponder，能响应事件


// 下面两个方法不是同步的，是异步的，和Runloop有关，下一次runloopa开始的时候
[self setNeedsDisplay]; // drawRect
[self setNeedLayout]；  // layoutSubView


#endif /* ___h */
