//
//  DoubleLinked.cpp
//  Algorithm
//
//  Created by xiaoyuan on 2020/10/11.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#include "DoubleLinked.hpp"

// 构造函数
template <class T>
DoubleLinked<T>::DoubleLinked(): count(0)
{
    // 创建表头，注意表头没有存储数据
    // 初始化时，pHead的next和previous结点都指向自身
    pHead = new DNode<T>();
    pHead->previous = pHead->next = pHead;
    
}

// 析构函数
template <class T>
DoubleLinked<T>::~DoubleLinked()
{
    // 删除所有呀
    DNode<T> *pTmp;
    DNode<T> *pNode = pHead->next;
    while (pNode != pHead) {
        pTmp = pNode;
        pNode = pNode->next;
        delete pTmp;
    }
    
    // 删除表头
    delete pHead;
    pHead = NULL;
}

// 结点的数量
template <class T>
int DoubleLinked<T>::size()
{
    return this->count;
}

// 链表是否为空
template <class T>
bool DoubleLinked<T>::isEmpty()
{
    return count == 0;
}

// 根据索引index 获取对应的结点
template <class T>
DNode<T>* DoubleLinked<T>::getNode(int index)
{
    // 判断参数是否有效
    if (index < 0 || index >= count) {
        cout << "get node failed! the index in out of bound!" << endl;
        return NULL;
    }
    
    // 正向查找
    if (index <= count / 2) {
        int i = 0;
        DNode<T> *pNode = pHead->next;
        while (i++ < index) {
            pNode = pNode->next;
        }
        return pNode;
    }
    
    // 反向查找
    int j = 0;
    int rIndex = count - index - 1;
    DNode<T> *pNode = pHead->previous;
    while (j++ < rIndex) {
        pNode = pNode->previous;
    }
    return pNode;;
}


// 根据索引index获取结点对应的value
template <class T>
T DoubleLinked<T>::get(int index)
{
    return getNode(index)->value;
}

// 获取第一个结点的值
template <class T>
T DoubleLinked<T>::getFirst()
{
    return getNode(0)->value;
}

// 获取最后一个结点的值
template <class T>
T DoubleLinked<T>::getLast()
{
    return getNode(count-1)->value;
}

// 将结点插入到头部
template <class T>
bool DoubleLinked<T>::insertFirst(T t)
{
    if (t == NULL) {
        return false;
    }
    DNode<T> *pNode = new DNode<T>(t, pHead, pHead->next);
    pHead->next->previous = pNode;
    pHead->next = pNode;
    count++;
    return true;
}

// 将结点添加到尾部
template <class T>
bool DoubleLinked<T>::appendLast(T t)
{
    if (t == NULL) {
        return false;
    }
    
    DNode<T> *pNode = new DNode<T>(t, pHead->previous, pHead);
    pHead->previous->next = pNode;
    pHead->previous = pNode;
    count++;
    return true;
}

// 在索引index的位置插入元素
template <class T>
bool DoubleLinked<T>::insert(int index, T t)
{
    if (t == NULL) {
        return false;
    }
    
    index = max(0, min(index, count - 1));
    
    if (index == 0) {
        return insertFirst(t);
    }
    
    DNode<T> *nodeOfIndex = getNode(index);
    DNode<T> *pNode = new DNode<T>(t, nodeOfIndex->previous, nodeOfIndex);
    nodeOfIndex->previous->next = pNode;
    nodeOfIndex->previous = pNode;
    count++;
    return true;
}

// 删除索引对应的结点
template <class T>
bool DoubleLinked<T>::remove(int index)
{
    DNode<T> *nodeOfIndex = getNode(index);
    if (nodeOfIndex == NULL) {
        return false;
    }
    // 移除pNode重新连接链表
    nodeOfIndex->next->previous = nodeOfIndex->previous;
    nodeOfIndex->previous->next = nodeOfIndex->next;
    count--;
    delete nodeOfIndex;
    return true;
}

// 删除第一个结点
template <class T>
bool DoubleLinked<T>::removeFirst()
{
    return remove(0);
}

// 删除最后一个元素
template <class T>
bool DoubleLinked<T>::removeLast()
{
    return remove(count-1);
}
