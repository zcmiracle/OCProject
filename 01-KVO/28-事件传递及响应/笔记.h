//
//  笔记.h
//  01-KVO
//
//  Created by Fearless on 2020/3/29.
//  Copyright © 2020 XFB. All rights reserved.
//

#ifndef ___h
#define ___h

1、iOS有哪些事件
2、触摸事件的整体流程 （Runloop相关、事件传递和响应）
3、事件传递流程：hitTest、pointInside来找到这个view
4、hitTest方法里面的实现

5、事件响应：UIResponder 这个类，因为每个View都有一个nextResponder的对象，所以串联了一个响应链
6、有了上面的响应链，然后就会进行touch四个方法的传递响应，你可以不写super touchbegin/moved/cancel/end来阻止这个传递流程
7、手势和hitTest、pointInside的关联；手势种类的识别；手势和touch事件的关系
8、button和hitTest、pointInside的关联；button事件种类的识别；button事件的响应


1、发生触摸事件后，系统会将该事件加入到一个由UIApplication管理的事件队列中
2、UIApplication会从事件队列中取出最前面的事件(队列：先进先出)，并将事件分发下去以便处理
通常，先发送事件给应用程序的主窗口（keyWindow）
3、主窗口会在视图结构中 找到一个最合适的视图来处理触摸事件，这也是整个事件处理过程的第一步
4、找到最合适的视图控件后，就会调用视图控件的 touches 方法来做具体的事件处理


*** 触摸事件的传递是从父控件传递到子控件
如果父控件不能接收触摸事件，那么子控件就不可能接收到触摸事件
UIView三种不接收触摸事件的三种情况
1、userInteractionEnable = NO
2、hidden = YES
3、alpha = 0.0 ~ 0.01
UIImageView的userInteractionEnable 默认就是NO，
因此UIImageView以及它的子控件默认是不能接收触摸事件的

如何找到最合适的控件来处理事件？
1、自己是否能接收触摸事件？
2、触摸点是否在自己身上
3、从后往前遍历子控件，重复前面2个步骤
4、如果没有符合条件的子控件，那么就自己最合适处理



touchesBegan
touchesMoved
touchesCancelled
touchesEnded

#endif /* ___h */
