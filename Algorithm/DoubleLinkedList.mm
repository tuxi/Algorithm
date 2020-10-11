//
//  DoubleLinkedList.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/10/11.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import "DoubleLinkedList.h"
#include "DoubleLinked.cpp"

using namespace std;

@implementation DoubleLinkedList

+ (void)test {
    
//    int arr[4] = {10, 20, 30, 40};
    
    cout << "开始测试双向链表" << endl;
    
    // 创建双向链表
    DoubleLinked<int> *pLinked = new DoubleLinked<int>();
    // 将20插入到第一个位置
    pLinked->insert(0, 20);
    // 在链表的尾部插入10
    pLinked->appendLast(10);
    // 将30插入到第一个位置
    pLinked->insertFirst(30);
    
    // 判断双向链表是否为空
    cout << "isEmpty()=" << pLinked->isEmpty() << endl;
    
    // 双向链表的大小
    cout << "size()=" << pLinked->size() << endl;
    
    // 打印双向链表中的全部数据
    for (int i = 0; i < pLinked->size(); i++) {
        cout << "pLinded("<<i<<")=" << pLinked->get(i) << endl;
    }
}

@end
