//
//  main.m
//  06-Block变量捕获
//
//  Created by XFB on 2020/3/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

// 全局变量
int globalAge = 10;
// 静态全局变量
static int staticGlobalAge = 20;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 最后这命令含有runtime指令 不然还是有些不同 比如默认对象都会有__strong 
        // xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-12.0.0 main.m
        
        // 基本数据类型的局部变量
        int age = 30;
        // 对象类型的局部变量
        __strong NSObject *obj = [[NSObject alloc] init];
        // 静态局部变量
        static int staticAge = 40;
        
        void(^Block)(void) = ^{
            NSLog(@"局部变量---基本数据类型：%d", age);
            NSLog(@"局部变量---对象类型：%@", obj);
            NSLog(@"静态局部变量：%d", staticAge);
            NSLog(@"全局变量：%d", globalAge);
            NSLog(@"静态全局变量：%d", staticGlobalAge);
        };
        // Block的调用就是函数调用
        Block();
    }
    return 0;
}


#if 0

// 全局变量 + 静态全局变量不捕获
int globalAge = 10;
static int staticGlobalAge = 20;

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;   // Block相关描述
    
    // 静态变量 基本数据类型 捕获其值
    int age;
    // 静态变量 对象类型 连同其所有权修饰符一起捕获
    NSObject *__strong obj;
    // 静态局部变量 捕获其地址
    int *staticAge;
    
    // C++中结构体的构造函数及定义
    // *fp 函数指针
    // *desc block的描述
    // _age 局部变量 基本数据类型
    // *__strong _obj 局部变量 对象类型
    // flags=0 标记
    // age(_age) 将构造函数传递进来的_age 赋值给上面的int age; 也就是结构体中的age
    // obj(_obj)
    // staticAge(_staticAge)
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _age, NSObject *__strong _obj, int *_staticAge, int flags=0) : age(_age), obj(_obj), staticAge(_staticAge) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;                 // 标记位赋值
        impl.FuncPtr = fp;                  // 函数指针赋值
        Desc = desc;                        // Block描述赋值
    }
};

// 所在类名_所在的方法_block_func_0 函数
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    
    // 下面三个输出对应下面三个取值
//    NSLog(@"局部变量---基本数据类型：%d", age);
//    NSLog(@"局部变量---对象类型：%@", obj);
//    NSLog(@"静态局部变量：%d", staticAge);
    
    // 通过入参__cself取出age成员变量
    int age = __cself->age; // bound by copy
    NSObject *__strong obj = __cself->obj; // bound by copy
    int *staticAge = __cself->staticAge; // bound by copy
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders__9_hnm3f8815kzgrmhn4q8x07600000gn_T_main_fa78a7_mi_0, age);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders__9_hnm3f8815kzgrmhn4q8x07600000gn_T_main_fa78a7_mi_1, obj);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders__9_hnm3f8815kzgrmhn4q8x07600000gn_T_main_fa78a7_mi_2, (*staticAge));
    NSLog((NSString *)&__NSConstantStringImpl__var_folders__9_hnm3f8815kzgrmhn4q8x07600000gn_T_main_fa78a7_mi_3, globalAge);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders__9_hnm3f8815kzgrmhn4q8x07600000gn_T_main_fa78a7_mi_4, staticGlobalAge);
}

// 将block从栈拷贝到堆
static void __main_block_copy_0(struct __main_block_impl_0*dst,
                                struct __main_block_impl_0*src) {
    _Block_object_assign((void*)&dst->obj, (void*)src->obj, 3/*BLOCK_FIELD_IS_OBJECT*/);}

// 销毁block
static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->obj, 3/*BLOCK_FIELD_IS_OBJECT*/);}

struct __block_impl {
  void *isa;        // isa指针，Block是对象的标志
  int Flags;        // 标志位
  int Reserved;     //
  void *FuncPtr;    // 函数指针（无类型的）
};

static struct __main_block_desc_0 {
    size_t reserved;    //
    size_t Block_size;  // Block的长度
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = {
    0,
    sizeof(struct __main_block_impl_0),
    __main_block_copy_0,        // 当调用copy方法适合 会调用 将Block从栈拷贝到堆
    __main_block_dispose_0};    // 销毁Block

int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
        
        // 局部变量 基本数据类型
        int age = 30;
        // 局部变量 对象类型
        __attribute__((objc_ownership(strong))) NSObject *obj = ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("alloc")), sel_registerName("init"));
        // 静态局部变量
        static int staticAge = 40;
        
        // 全局变量+静态全局变量不捕获
        
        // Block
        // __main_block_func_0 函数
        // (void *)__main_block_func_0  函数指针f *fp
        void(*Block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, age, obj, &staticAge, 570425344));
        
        void(^Block)(void) = ^{
            NSLog(@"局部变量---基本数据类型：%d", age);
            NSLog(@"局部变量---对象类型：%@", obj);
            NSLog(@"静态局部变量：%d", staticAge);
            NSLog(@"全局变量：%d", globalAge);
            NSLog(@"静态全局变量：%d", staticGlobalAge);
        };
        
        // Block调用 就是函数调用
        Block();
        // (__block_impl *)Block 强制类型转换
        // 转换之后取出成员变量 ((__block_impl *)Block)->FuncPtr
        // FuncPtr 位于 Block的结构体中 __block_impl
        // 通过函数指针取到对应的函数执行体 将参数传递进去 参数1：Block本身
        // 然后就会调用 __main_block_func_0()
        ((void (*)(__block_impl *))((__block_impl *)Block)->FuncPtr)((__block_impl *)Block);
    }
    return 0;
}
static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };


#endif
