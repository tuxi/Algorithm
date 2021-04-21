//
//  LRUCache.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/9/28.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import "LRUCache.h"
#include <iostream>
#include <map>

/*
 缓存算法和LRU的c++实现
 资料：https://www.cnblogs.com/cpselvis/p/6272096.html
 常见的缓存算法
 LRU (Least recently used) 最近最少使用，如果数据最近被访问过，那么将来被访问的几率也更高。
 LFU (Least frequently used) 最不经常使用，如果一个数据在最近一段时间内使用次数很少，那么在将来一段时间内被使用的可能性也很小。
 FIFO (Fist in first out) 先进先出， 如果一个数据最先进入缓存中，则应该最早淘汰掉。
 LRU缓存
 
 实现步骤
 像浏览器的缓存策略、memcached的缓存策略都是使用LRU这个算法，LRU算法会将近期最不会访问的数据淘汰掉。LRU如此流行的原因是实现比较简单，而且对于实际问题也很实用，良好的运行时性能，命中率较高。下面谈谈如何实现LRU缓存：
 1.新数据插入到链表头部
 2.每当缓存命中（即缓存数据被访问），则将数据移到链表头部
 3.当链表满的时候，将链表尾部的数据丢弃
 
 LRUCache的c++实现
 LRU实现采用双向链表 + Map 来进行实现。这里采用双向链表的原因是：如果采用普通的单链表，则删除节点的时候需要从表头开始遍历查找，效率为O(n)，采用双向链表可以直接改变节点的前驱的指针指向进行删除达到O(1)的效率。使用Map来保存节点的key、value值便于能在O(logN)的时间查找元素,对应get操作。
 */

using namespace std;

/**
 * Definition of cachelist node, it's double linked list node.
 * 双链表结点
 */
struct CacheNode {
    // 键
    int key;
    // 值
    int value;
    // 结点前驱 和 后继指针
    CacheNode *pre, *next;
    CacheNode(int k, int v) : key(k), value(v), pre(NULL), next(NULL) {}
};


class LRUCachePrivate {
private:
    // 缓存策略设置的最大缓存个数
    int size;                     // Maximum of cachelist size.
    // 链表头指针 和 链表尾指针
    CacheNode *head, *tail;
    // 存储数据的容器map
    map<int, CacheNode *> mp;          // Use hashmap to store
public:
    LRUCachePrivate(int capacity): size(capacity), head(NULL), tail(NULL) {}
    
    // get(key)操作的实现比较简单，直接通过判断Map是否含有key值即可，
    // 如果查找到key，则返回对应的value，否则返回-1;
    int get(int key)
    {
        map<int, CacheNode *>::iterator it = mp.find(key);
        if (it != mp.end())
        {
            CacheNode *node = it -> second;
            remove(node);
            setHead(node);
            return node -> value;
        }
        else
        {
            return -1;
        }
    }
    
    /*
     set(key, value)操作需要分情况判断。如果当前的key值对应的节点已经存在，
     则将这个节点取出来，并且删除节点所处的原有的位置，并在头部插入该节点；
     如果节点不存在节点中，这个时候需要在链表的头部插入新节点，插入新节点可能导致容量溢出，如果出现溢出的情况，则需要删除链表尾部的节点。
     **/
    void set(int key, int value)
    {
        // 从map中查找key对应的vlaue
        map<int, CacheNode *>::iterator it = mp.find(key);
        if (it != mp.end())
        {
            // 如果找到了，则说明被命中，符合最近最少使用原则（如果数据最近被访问过，那么将来被访问的几率也更高）
            CacheNode *node = it -> second;
            node -> value = value;
            // 在链表中删除此结点
            remove(node);
            // 并将此结点插入到链表头部
            setHead(node);
        }
        else
        {
            // 创建一个新的缓存结点
            CacheNode *newNode = new CacheNode(key, value);
            if (mp.size() >= size)
            {
                // 如果链表满了，则移除尾部结点
                map<int, CacheNode *>::iterator iter = mp.find(tail -> key);
                // 从链表中移除尾部的结点
                remove(tail);
                // 从map中擦除尾部这个结点
                mp.erase(iter);
            }
            // 将新的结点设置为头结点
            setHead(newNode);
            // 并保存在map中
            mp[key] = newNode;
        }
    }
    
    // 在链表中删除此结点
    void remove(CacheNode *node)
    {
        if (node -> pre != NULL)
        {
            node -> pre -> next = node -> next;
        }
        else
        {
            head = node -> next;
        }
        if (node -> next != NULL)
        {
            node -> next -> pre = node -> pre;
        }
        else
        {
            tail = node -> pre;
        }
    }
    
    // 将节点插入到头部的操作
    void setHead(CacheNode *node)
    {
        // 设置node参数为头结点
        // 重新连接当前头结点
        
        node -> next = head;
        node -> pre = NULL;
        
        if (head != NULL)
        {
            head -> pre = node;
        }
        head = node;
        if (tail == NULL)
        {
            tail = head;
        }
    }
};


@implementation LRUCache {
    LRUCachePrivate *_lruCache;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化LRU策略的缓存，最大的内存空间为2个元素
        _lruCache = new LRUCachePrivate(2);
    }
    return self;
}

- (void)test {
    // 缓存两个元素
    _lruCache->set(2, 1);
    _lruCache->set(1, 1);
    
    
    cout << _lruCache->get(2) << endl;
    
    // 缓存第三个元素，此时，会将第三个元素插入到链表头部，尾部的元素会被移除
    _lruCache->set(4, 1);
    // 此时取1对应的元素应该不存在，-1
    cout << _lruCache->get(1) << endl;
    // 2还可以取到
    cout << _lruCache->get(2) << endl;
}

@end
