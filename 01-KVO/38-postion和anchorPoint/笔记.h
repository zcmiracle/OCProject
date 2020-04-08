//
//  笔记.h
//  01-KVO
//
//  Created by XFB on 2020/4/8.
//  Copyright © 2020 XFB. All rights reserved.
//

#ifndef ___h
#define ___h

position：
1、用来设置CALayer在父层中的位置
2、以父层的左上角为原点（0, 0）

anchorPoint：
1、锚点
2、决定着CALayer身上哪个点会在position属性所指的位置
3、以自己的左上角为原点 (0, 0)
4、它的x、y取值范围都是0~1， 默认值为(0.5, 0.5)


UIView 默认有CALayer层，根层
手动创建的CALayer默认是非根层，修改属性会产生隐式动画



#endif /* ___h */
