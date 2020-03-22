//
//  main.m
//  07-__block修饰符
//
//  Created by Fearless on 2020/3/22.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MyBlock1)(void);
typedef void(^MyBlock2)(void);
typedef void(^MyBlock3)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-12.0.0 main.m
        
        __block int age = 18;
        __block NSObject *obj = [[NSObject alloc] init];
        
        // __block 可以用于解决block内部无法修改auto变量值的问题
        // __block 不能修改全局变量、静态变量static
        MyBlock1 block1 = ^{
            NSLog(@"%d", age);
            NSLog(@"%@", obj);
        };
        
        MyBlock2 block2 = ^{
            
        };
        
        MyBlock3 block3 = ^{
            age = 20;
        };
        
        block1();
        block2();
        block3();
    }
    return 0;
}

#if 0

typedef void(*MyBlock1)(void);
typedef void(*MyBlock2)(void);
typedef void(*MyBlock3)(void);

struct __Block_byref_age_0 {
    void *__isa;
    __Block_byref_age_0 *__forwarding;
    int __flags;
    int __size;
    int age;
};

struct __Block_byref_obj_1 {
    void *__isa;
    // 指向自己的结构体指针
    __Block_byref_obj_1 *__forwarding;
    int __flags;
    int __size;
    void (*__Block_byref_id_object_copy)(void*, void*);
    void (*__Block_byref_id_object_dispose)(void*);
    NSObject *__strong obj;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    __Block_byref_age_0 *age; // by ref
    __Block_byref_obj_1 *obj; // by ref
    // 引用__block 修饰的auto变量(基本数据类型 + 对象类型)
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_age_0 *_age, __Block_byref_obj_1 *_obj, int flags=0) : age(_age->__forwarding), obj(_obj->__forwarding) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

// MyBlock1执行的函数
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    __Block_byref_age_0 *age = __cself->age; // bound by ref
    __Block_byref_obj_1 *obj = __cself->obj; // bound by ref
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kk_w2rrw2q901vb4tpxn06k17qr0000gn_T_main_a41c1a_mi_0, (age->__forwarding->age));
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_kk_w2rrw2q901vb4tpxn06k17qr0000gn_T_main_a41c1a_mi_1, (obj->__forwarding->obj));
}

static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {
    _Block_object_assign((void*)&dst->age, (void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);
    _Block_object_assign((void*)&dst->obj, (void*)src->obj, 8/*BLOCK_FIELD_IS_BYREF*/);}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {
    _Block_object_dispose((void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);
    _Block_object_dispose((void*)src->obj, 8/*BLOCK_FIELD_IS_BYREF*/);}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};

struct __main_block_impl_1 {
    struct __block_impl impl;
    struct __main_block_desc_1* Desc;
    // 没有引入__block 修饰的auto变量
    __main_block_impl_1(void *fp, struct __main_block_desc_1 *desc, int flags=0) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

// MyBlock2执行的函数
static void __main_block_func_1(struct __main_block_impl_1 *__cself) {
    
}

static struct __main_block_desc_1 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_1_DATA = { 0, sizeof(struct __main_block_impl_1)};

struct __main_block_impl_2 {
    struct __block_impl impl;
    struct __main_block_desc_2* Desc;
    __Block_byref_age_0 *age; // by ref
    // 引用__block修饰的对象，并修改
    __main_block_impl_2(void *fp, struct __main_block_desc_2 *desc, __Block_byref_age_0 *_age, int flags=0) : age(_age->__forwarding) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

// MyBlock3执行的函数
static void __main_block_func_2(struct __main_block_impl_2 *__cself) {
    __Block_byref_age_0 *age = __cself->age; // bound by ref
    (age->__forwarding->age) = 20;
}

static void __main_block_copy_2(struct __main_block_impl_2*dst, struct __main_block_impl_2*src) {
    _Block_object_assign((void*)&dst->age, (void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);}

static void __main_block_dispose_2(struct __main_block_impl_2*src) {
    _Block_object_dispose((void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);}

static struct __main_block_desc_2 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_2*, struct __main_block_impl_2*);
    void (*dispose)(struct __main_block_impl_2*);
} __main_block_desc_2_DATA = { 0, sizeof(struct __main_block_impl_2), __main_block_copy_2, __main_block_dispose_2};

int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
        
        
        // __block int age = 18;
        /**
         struct __Block_byref_age_0 {
             void *__isa;
             __Block_byref_age_0 *__forwarding;
             int __flags;
             int __size;
             int age;
         };
         */
        __attribute__((__blocks__(byref))) __Block_byref_age_0 age = {
            (void*)0,                       // isa
            (__Block_byref_age_0 *)&age,    // __forwarding
            0,                              // int __flags
            sizeof(__Block_byref_age_0),    // int __size;
            18                              // int age
        };
        
        
        /**
         MyBlock1 block1 = ^{
            NSLog(@"%d", age);
            NSLog(@"%@", obj);
         };
         
         __main_block_impl_0(
                        void *fp,
                        struct __main_block_desc_0 *desc,
                        __Block_byref_age_0 *_age,
                        __Block_byref_obj_1 *_obj,
                        int flags=0)

         

         */
        // 首先调用构造函数
        MyBlock1 block1 = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0,    // *fp
                                                            &__main_block_desc_0_DATA,      // *desc
                                                            (__Block_byref_age_0 *)&age,    // *_age
                                                            (__Block_byref_obj_1 *)&obj,    // *_objc;
                                                            570425344));                    // flags
        

        // __block NSObject *obj = [[NSObject alloc] init];
        __attribute__((__blocks__(byref))) __Block_byref_obj_1 obj = {(void*)0,(__Block_byref_obj_1 *)&obj, 33554432, sizeof(__Block_byref_obj_1), __Block_byref_id_object_copy_131, __Block_byref_id_object_dispose_131, ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("alloc")), sel_registerName("init"))};

        // MyBlock1 block1 = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_age_0 *)&age, (__Block_byref_obj_1 *)&obj, 570425344));
        MyBlock2 block2 = ((void (*)())&__main_block_impl_1((void *)__main_block_func_1, &__main_block_desc_1_DATA));
        MyBlock3 block3 = ((void (*)())&__main_block_impl_2((void *)__main_block_func_2, &__main_block_desc_2_DATA, (__Block_byref_age_0 *)&age, 570425344));
        
        ((void (*)(__block_impl *))((__block_impl *)block1)->FuncPtr)((__block_impl *)block1);
        ((void (*)(__block_impl *))((__block_impl *)block2)->FuncPtr)((__block_impl *)block2);
        ((void (*)(__block_impl *))((__block_impl *)block3)->FuncPtr)((__block_impl *)block3);
    }
    return 0;
}
static struct IMAGE_INFO { unsigned version; unsigned flag; } _OBJC_IMAGE_INFO = { 0, 2 };


#endif
