//
//  LinkedArray.h
//  Algorithm
//
//  Created by xiaoyuan on 2020/8/31.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//  OC字典底层实现模拟(数组+链表)

/*
 OC中的字典实际上为一个数组 ， 数组中的每个元素同样为一个链表实现的数组 ，也就是数组中套数组。
 为什么要这么设计 ？
 原因有二：
 1.每个对象创建时，都默认生产一个hashCode，也就是一个经过哈希算法生成的一串数字。当利用key去取字典中的value时，若是使用遍历或者二分查找等方法，效率都相对较低，于是出现了根据每个key生成的hashCode将该键值对防盗hashCode对应的数组中指定的位置，这样当用key去取值时，便不必遍历去获取，即可以根据hashCode直接取出。
 2.hashCode数字过大，或许会经过取余生成一个较小的数字，利于是对999进行取余，那么得到的结果始终处于0～999之间。但是，这样做的弊端在于取余所得到的值，可能是相同的，这样可能导致完全不相干的键值对（取余后值key相等）而覆盖。于是出现了数组中套链表实现的数组。这样，key取余的到的值相等的键值对，都将保存在同一个链表数组中，当查找key所对应的值时，首先获取到该链表数组，然后遍历该数组，取出正确的key所对应的值即可。
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkedArray : NSObject

// 记录元素个数
@property (nonatomic, assign, readonly) NSUInteger count;

// 向数组的末尾添加元素
- (void)appendObject:(NSObject *)obj;

// 移除指定的元素
- (void)remove:(NSObject *)obj;

// 移除指定索引对应的元素
- (void)removeAtIndex:(NSInteger)index;

// 根据索引查找对应的元素
- (nullable NSObject *)objectAtIndex:(NSInteger)index;

// 便利构造方法
+ (instancetype)array;

@end

@interface Node : NSObject

// 上一个结点，指针域
@property (nonatomic, strong, nullable) Node *previous;
// 下一个结点，指针域
@property (nonatomic, strong, nullable) Node *next;
// 当前结点内容，数据域
@property (nonatomic, strong, nullable) id data;

@end

NS_ASSUME_NONNULL_END
