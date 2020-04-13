//
//  main.m
//  14-Category关联对象
//
//  Created by Fearless on 2020/3/23.
//  Copyright © 2020 XFB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+Category.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
 
        Person *person = [[Person alloc] init];
        person.name = @"Fearless";
        NSLog(@"%@", person.name);

        [person setValue:@"Miracle" forKey:@"name"];
        NSLog(@"%@", person.name);
        
        /**
         关联对象实现原理：
         1、关联对象存储在一个全局容器中，由一个AssociationManager来管理
         AssociationManager里面有一个成员变量 AssociationHaspMap 哈希表
         哈希表的key是传递的关联对象的指针地址 经过位运算取反 对应的value = ObjectAssociationMap
         ObjectAssociationMap管理者这个对象所有的关联值，也是一张map表
         key：用户手动传过去的key，value由用户传过去的value和policy组装的对象
         首先判断这个haspMap存在不。如果存在通过传过去的key判断ObjcAssociation 存在不，
         不存在将policy和key包装成一个对象，然后赋值，如果不存在，则将传过去的Policy和value包装成
         一个ObjcAssociation 然后赋值
         如果这个haspMap不存在，则新建ObjectAssociationMap 然后将policy和value包装成一个对象
         ObjcAssociation，最后将ObjcAssociation和key关联，
         
         objc_setAssociatedObject
                    
         _object_set_associative_reference {
            key: 对象的指针地址
            value:ObjectAssociatonMap
         }
         
         ObjectAssociatonMap {
            key: 传进来的key
            value:ObjcAssociation
         }
         
         ObjcAssociation(policy, new_Value)
         
         
         objc_getAssociatedObject
         
         _object_get_associative_reference
         
         */
        
        // 使用runtime Associate方法关联的对象，需要在主对象dealloc的时候释放吗？
        // 不需要释放
        // 主对象引用计数位0时，调用 release
        // 沿继承链 调用父类的dealloc
        // 直到调用NSObject的dealloc
        // 经过一系列函数调用栈
        // dealloc-->
        // _objc_rootDealloc-->
        // rootDealloc-->
        // object_dispose-->
        // objc_destructInstance 释放成员变量 + 移除关联属性 + 弱引用指向nil
        // free(this), free(obj)
        
        /**
         objc_destructInstance：
         1、object_cxxDestruct：释放成员变量(实例变量)
         2、_object_remove_associations：移除关联属性
         3、clearDeallocation：将弱引用置为nil
         
         总结：
         1、属性关联的对象不需要再主对象dealloc中释放
         2、它们会在NSObject-dealloc调用的object_dispose()
         3、释放时，如果是强引用retain，则release，如果是weak不是强引用不用管
         */
        
    }
    return 0;
}



#if 0


/**
 实例化一个AssociationsManager对象，用来管理所有关联对象
 AssociationsManager 内部有一个 AssociationsHashMap 列表  static AssociationsHashMap *_map;
 通过散列映射来管理对象和ObjcAssociation 之间的关系
 ObjcAssociation 才是真正存储关联对象的地方
 
 1、实例化AssociationsManager对象，获得AssociationsHashMap对象
 2、通过AssociationsHashMap获得对应的ObjcAssociation
 3、通过ObjcAssociation中取出对应的值，如果没有对应的关联对象，返回nil
 */

/// 关联对象实现 --- 用来给对象添加关联对象，传入nil则移除已有的关联对象
/// @param object 准备被关联的对象
/// @param key 要关联的值对应的key 标识
/// @param value 关联的值
/// @param policy 策略
void _object_set_associative_reference(id object, // 准备被关联的对象
                                       void *key, // 要关联的值对应的KEY
                                       id value,  // 关联的值
                                       uintptr_t policy // 策略
                                       ) {
    // retain the new value (if any) outside the lock.
    // 存放 policy 和 关联值默认为空
    ObjcAssociation old_association(0, nil);
                                           
    // 根据 策略 对 value 进行加工，按照策略对value进行 copy或者retain
    // newValue === 准备关联的值
    id new_value = value ? acquireValue(value, policy) : nil;
    {
        /**
         关联对象管理类，C++实现一个类
         初始化一个 AssociationsManager 对象
         它维护一个 单例 Hash 表 AssociationsHashMap对象
         */
        AssociationsManager manager;
        
        /**
         获取其维护的一个Hashmap，相当于一个字典 是一个全局容
         初始化一个 AssociationsHashMap 对象 associations
         用来维护 对象 和 ObjectAssociationMap
         */
        AssociationsHashMap &associations(manager.associations());
        
        // 获取关联对象的索引 ---------------> DISGUISE 对这个指针地址 按位取反
        disguised_ptr_t disguised_object = DISGUISE(object);
        if (new_value) {
            // break any existing association.
            // 根据对象指针查找对应的一个ObjectAssociateMap结构的map
            // 通过迭代器 找到对应的 ObjectAssociationMap
            AssociationsHashMap::iterator i = associations.find(disguised_object);
            
            // 全局容器中 找到了
            if (i != associations.end()) {
                // secondary table exists
                // i->first 表示对象指针
                // ************** i->second 表示获取 ObjectAssociationMap **************
                ObjectAssociationMap *refs = i->second;
                // 根据传递进来的key进行查找
                ObjectAssociationMap::iterator j = refs->find(key);
                if (j != refs->end()) {
                    // 如果查找到了 ObjcAssociation 里面是policy 和 value
                    // ObjcAssociation old_association(0, nil);
                    old_association = j->second;
                    // 如果关联对象已存在，则通过ObjcAssociation赋新值(替换最新的value)
                    j->second = ObjcAssociation(policy, new_value);
                } else {
                    // 如果关联对象不存在，则创建新的关联对象
                    (*refs)[key] = ObjcAssociation(policy, new_value);
                }
            } else {
                /**
                 create the new association (first time).
                 如果没有 ObjectAssociationMap 表
                 则第一次创建一个 ObjectAssociationMap 表
                 */
                ObjectAssociationMap *refs = new ObjectAssociationMap;
                // 全局容器中的key = disguised_object
                // 全局容器中的value = 这个新创建的map
                associations[disguised_object] = refs;
                // 新关联的值 new_value 通过策略 policy 组装成 ObjcAssociation 并封装好
                // 作为新创建好的map, ObjectAssociationMap[key]
                // key 传进来的key
                (*refs)[key] = ObjcAssociation(policy, new_value);
                // 最后设置这个对象是有关联对象
                object->setHasAssociatedObjects();
            }
        } else {
            /**
             setting the association to nil breaks the association.
             如果new_value为 空，那么删除该关联对象
             */
            // 通过传递过来的object，通过对内存地址的位运算作为key，去查询这个AssociationsHashMap
            AssociationsHashMap::iterator i = associations.find(disguised_object);
            // 查找到了这个map
            if (i !=  associations.end()) {
                // 获取到了这个对象的关联map
                ObjectAssociationMap *refs = i->second;
                // 通过key 到 ObjectAssociationMap中查找
                ObjectAssociationMap::iterator j = refs->find(key);
                if (j != refs->end()) {
                    // 找到了ObjcAssociation
                    old_association = j->second;
                    // 擦除操作，从ObjectAssociationMap中移除
                    // 所以我们想移除关联对象，可以将关联对象的值设置为nil进行移除
                    refs->erase(j);
                }
            }
        }
    }
    // release the old value (outside of the lock).
    if (old_association.hasValue()) ReleaseValue()(old_association);
}

/**
 1、用于删除所有关联的对象，一般不用
 */
void _object_remove_assocations(id object) {
    vector< ObjcAssociation,ObjcAllocator<ObjcAssociation> > elements;
    {
        AssociationsManager manager;
        AssociationsHashMap &associations(manager.associations());
        if (associations.size() == 0) return;
        disguised_ptr_t disguised_object = DISGUISE(object);
        AssociationsHashMap::iterator i = associations.find(disguised_object);
        if (i != associations.end()) {
            // copy all of the associations that need to be removed.
            ObjectAssociationMap *refs = i->second;
            for (ObjectAssociationMap::iterator j = refs->begin(), end = refs->end(); j != end; ++j) {
                elements.push_back(j->second);
            }
            // remove the secondary table.
            delete refs;
            associations.erase(i);
        }
    }
    // the calls to releaseValue() happen outside of the lock.
    for_each(elements.begin(), elements.end(), ReleaseValue());
}

// 用来得到已有的关联对象
id _object_get_associative_reference(id object, void *key) {
    id value = nil;
    uintptr_t policy = OBJC_ASSOCIATION_ASSIGN;
    {
        AssociationsManager manager;
        AssociationsHashMap &associations(manager.associations());
        disguised_ptr_t disguised_object = DISGUISE(object);
        AssociationsHashMap::iterator i = associations.find(disguised_object);
        if (i != associations.end()) {
            ObjectAssociationMap *refs = i->second;
            ObjectAssociationMap::iterator j = refs->find(key);
            if (j != refs->end()) {
                ObjcAssociation &entry = j->second;
                value = entry.value();
                policy = entry.policy();
                if (policy & OBJC_ASSOCIATION_GETTER_RETAIN) {
                    objc_retain(value);
                }
            }
        }
    }
    if (value && (policy & OBJC_ASSOCIATION_GETTER_AUTORELEASE)) {
        objc_autorelease(value);
    }
    return value;
}


#endif
