//
//  LinkedArray.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/8/31.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import "LinkedArray.h"

@interface LinkedArray()

// 首结点
@property (nonatomic, strong) Node *first;
// 尾结点
@property (nonatomic, strong) Node *last;

@property (nonatomic, assign) NSUInteger count;

@end

@implementation LinkedArray

- (instancetype)init {
    if (self = [super init]) {
        _count = 0;
    }
    return self;
}

- (void)appendObject:(NSObject *)obj {
    if (!obj) {
        return;
    }
    _count += 1;
    Node *node = [Node new];
    node.data = obj;
    if (!_first) {
        // 首个结点为空时，数组中没有元素
        _first = node;
        _last = node;
        node.next = nil;
        node.previous = nil;
        
    }
    else {
        // 数组中有元素时
        node.previous = _last;
        node.next = nil;
        _last = node;
        _last.next = node;
    }
}

- (void)remove:(NSObject *)obj {
    if (!obj || _count <= 0) {
        return;
    }
    
    Node *tempNode = _first;
    
    for (NSInteger index = 0; index < _count; index++) {
        if ([tempNode.data isEqual:obj]) {
            [self _removeNode:tempNode];
            break;
        }
        tempNode = tempNode.next;
    }
}

- (void)removeAtIndex:(NSInteger)index {
    if (index < 0 || index >= _count) {
        return;
    }
    
    Node *tempNode = _first;
    for (NSInteger i = 0; i < _count; i++) {
        if (i == index) {
            [self _removeNode:tempNode];
            break;
        }
        tempNode = tempNode.next;
    }
}

- (NSObject *)objectAtIndex:(NSInteger)index {
    if (index < 0 || index >= _count) {
        return nil;
    }
    
    Node *tempNode = _first;
    
    for (NSInteger i = 0; i < _count; i++) {
        if (i == index) {
            return tempNode.data;
        }
        tempNode = tempNode.next;
    }
    return nil;
}

- (void)_removeNode:(Node *)node {
    // 移除某个结点时，需要重新连接上下结点
    Node *preNode = node.previous;
    Node *nextNode = node.next;
    preNode.next = nextNode;
    nextNode.previous = preNode;
    // 清除被移除结点的内容
    node.data = nil;
    // 更新数组长度
    _count -=1;
}

+ (instancetype)array {
    return [self new];
}

@end

@implementation Node


@end
