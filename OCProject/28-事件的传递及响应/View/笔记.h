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

//=================================//
触摸事件处理的详细过程
1、用户点击屏幕后产生一个触摸事件，经过一系列的传递过程后，会找到最合适的视图控件来处理这个事件
2、找到最合适的视图控件后，就会调用控件的touches方法来做具体的事件处理
touchesBegan
touchesMoved
touchedEnded
touchedCancelled
3、这些touches方法的默认做法 将事件顺着响应者链条向上传递，将事件交给上一个响应者进行处理


响应者链条
1、响应者链条：是由多个响应者对象连接起来的链条
作用：能清楚的看见每个响应者之间的联系，并且可以让一个事件多个对象处理
响应者对象：能处理事件的对象

//=================================//
总结：
事件传递的完整过程
1、先将事件对象 由上往下（由父控件传递到子控件），找到最合适的控件来处理这个事件
2、调用最合适控件的 touche... 方法
3、如果调用了 [super touches...] 就会将事件顺着响应者链条往上传递，传递给上一个响应者
4、接着就会调用上一个响应者的 touches... 方法

如何判断上一个响应者
1、如果当前这个view是控制器的view，那么控制器就是上一个响应者
2、如果当前这个view不是控制器的view，那么父控件就是上一个响应者

自己总结：
从UIApplication出发到UIWindow到UIViewController到UIView
当用户触摸屏幕后，先由上往下找最合适的view，调用hitTest和pointInside两个方法，
并且倒序遍历找到最合适的view，找到最合适的view的方法：
三种情况：
情况1：判断自身是否能接收事件
情况2：判断自身是否隐藏
情况3：判断自身alpha是否 > 0.01
首先判断当前view是否能接收触摸事件(3种情况)，判断当前view是否在自身坐标系上（pointInside），倒序遍历view的子控件，如果子控件没有找到最合适的view
那么当前view是最合适的view，
如果子控件中找到了最合适的view直接返回，并且开始调用touches...方法
找到最合适的view处理touches...方法

如果调用了super的方法，默认将事件向上传递（顺着响应者链条向上传递，传递给上一个响应者），下面是判断上一个响应者
如果当前view是控制器的view，那么控制器就是上一个响应者
如果当前view不是控制器的view，那么上一个响应者是父控件

#endif /* ___h */
