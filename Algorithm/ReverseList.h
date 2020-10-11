//
//  ReverseList.h
//  Algorithm
//
//  Created by xiaoyuan on 2020/8/31.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//  单链表反转

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 定义一个链表
struct Node {
    void *data;
    struct Node *next;
};

@interface LinkedList : NSObject

@property (nonatomic, readonly) struct Node *list;

- (instancetype)initWithArray:(NSArray *)array;
- (void)reverse;
- (void)enumerateObjectsUsingBlock:(void ( ^)(struct Node *obj, NSUInteger idx, BOOL *stop))block;
@end

@interface ReverseList : NSObject

// 链表反转
+ (struct Node *)reverseList:(struct Node *)head;
// 已知链表头结点指针head，将链表从位置startIndex到endIndex的逆序（不能申请额外的空间）
+ (struct Node *)reverseBetween:(struct Node *)head startIndex:(int)startIndex endIndex:(int)endIndex;
// 构造一个链表
+ (struct Node *)constructList;
// 打印链表中的数据
+ (void)printList:(struct Node *)head;
@end

NS_ASSUME_NONNULL_END
