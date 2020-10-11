//
//  DoubleLinked.hpp
//  Algorithm
//
//  Created by xiaoyuan on 2020/10/11.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#ifndef DoubleLinked_hpp
#define DoubleLinked_hpp

#include <iostream>

using namespace std;

/// 双向链表的一个结点
template <class T>
struct DNode {
public:
    T value;
    DNode *previous;
    DNode *next;
public:
    DNode() {}
    DNode(T value, DNode *previous, DNode *next):
        value(value), previous(previous), next(next) {}
    ~DNode() {
        cout << "释放了节点DNode" << endl;
    };
};

template <class T>
class DoubleLinked {
    
public:
    DoubleLinked();
    ~DoubleLinked();
    
    // 结点的数量
    int size();
    // 判断是否为空
    bool isEmpty();
    // 根据索引获取结点的value
    T get(int index);
    // 获取第一个结点的value
    T getFirst();
    // 获取最后一个结点的value
    T getLast();
    // 在指定索引位置插入一个结点的value
    bool insert(int index, T t);
    // 在第一个结点前面插入一个结点的value
    bool insertFirst(T t);
    // 在最后一个结点后面添加结点的value
    bool appendLast(T t);
    
    // 删除指定索引的结点
    bool remove(int index);
    // 删除第一个结点
    bool removeFirst();
    // 删除最后一个结点
    bool removeLast();
    
private:
    // 结点的数量
    int count;
    // 头结点指针，注意第一个结点为phead的next结点，最后一个结点为pHead的previous结点
    DNode<T> *pHead;
private:
    DNode<T> *getNode(int index);
};


#endif /* DoubleLinked_hpp */
