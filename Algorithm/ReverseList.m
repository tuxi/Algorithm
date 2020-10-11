//
//  ReverseList.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/8/31.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import "ReverseList.h"

@implementation ReverseList

+ (struct Node *)constructList {
    // 定义头部结点
    struct Node *head = NULL;
    // 记录当前尾结点
    struct Node *current = NULL;
    
    for (int i = 1; i < 8; i++) {
        struct Node *node = malloc(sizeof(struct Node));
        node->data = i;
        node->next = NULL;
        // 头结点为空，新结点即为头结点
        if (head == NULL) {
            head = node;
        }
        else {
            // 当前结点的next为新结点
            current->next = node;
        }
        // 设置当前结点为新结点
        current = node;
    }
    return head;
}

+ (struct Node *)reverseList:(struct Node *)head {
    // 定义遍历指针，初始化为头结点
    struct Node *p = head;
    // 反转后的链表头部
    struct Node *newH = NULL;
    
    // 遍历链表
    while (p != NULL) {
        // 记录下一个结点
        struct Node *temp = p->next;
        // 当前结点的next 指向新链表的头部
        p->next = newH;
        // 更改新链表的头部为当前结点
        newH = p;
        // 移动p指针
        p = temp;
    }
    // 返回反转后的链表头结点
    return newH;
}

// 已知链表头结点指针head，将链表从位置startIndex到endIndex的逆序（不能申请额外的空间）
+ (struct Node *)reverseBetween:(struct Node *)head startIndex:(int)startIndex endIndex:(int)endIndex  {
    
    //在原始数据未操作前进行计算修改长度
    int len = endIndex - startIndex + 1;
    
    struct Node *result = head;
    
    // 找到startIndex的前一个结点
    // preHead 用来标记逆序的前一个结点
    struct Node *preHead = NULL;
    while (head && --startIndex) {
        preHead = head;
        head = head->next;
    }
    
    // 标记逆序链表的头结点
    struct Node *reverTail = head;
    // 逆序截止的位置是endIndex - startIndex + 1
    
    struct Node *prev = NULL;
    while (head && len) {
        struct Node *node = head->next;
        head->next = prev;
        prev = head;
        head = node;
        len--;
    }
  
    // 完成逆序之后首尾相连问题
    reverTail->next = head;
    
    if (preHead) {
        // 检查逆序链表开始的位置，返回整个数组的头结点
        preHead->next = prev;
    }
    else {
        result = prev;
    }
    return result;
}

+ (void)printList:(struct Node *)head {
    struct Node *temp = head;
    while (temp != NULL) {
        printf("node is %d \n", (int)temp->data);
        temp = temp->next;
    }
}

@end

@interface LinkedList ()

@property (nonatomic) struct Node *list;

@end

@implementation LinkedList

- (instancetype)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        
        // 定义头结点
        struct Node *head = NULL;
        // 记录当前结点
        struct Node *current = NULL;
        
        for (id item in array) {
            struct Node *node = malloc(sizeof(struct Node));
            node->data = (__bridge void *)item;
            node->next = NULL;
            
            if (head == NULL) {
                // 头结点为空，新的结点即为头结点
                head = node;
            }
            else {
                // 当前结点的next 为新结点
                current->next = node;
            }
            // 设置当前结点为新结点
            current = node;
        }
        
        self.list = head;
    }
    return self;
}

- (void)reverse {
    // 定义遍历指针，初始化为头结点
    struct Node *p = self.list;
    // 初始化反转后的头结点
    struct Node *newH = NULL;
    
    // 遍历链表
    while (p != NULL) {
        // 记录下一个结点
        struct Node *temp = p->next;
        // 当前结点的next 指向新链表的头部
        p->next = newH;
        // 更改新链表的头部为当前结点
        newH = p;
        // 移动p指针
        p = temp;
    }
    self.list = newH;
}

- (void)enumerateObjectsUsingBlock:(void (^)(struct Node * _Nonnull, NSUInteger, BOOL * _Nonnull))block {
    struct Node *temp = self.list;
    NSInteger index = 0;
    BOOL stop = NO;
    while (temp != NULL) {
        if (stop == YES) {
            break;
        }
        if (block) {
            block(temp, index, &stop);
        }
        temp = temp->next;
        index += 1;
    }
}

- (void)dealloc {
    // 单链表释放
    struct Node *p = self.list;
    while (p != NULL) {
        struct Node *temp = p;
        p = p->next;
        free(temp);
    }
    self.list = NULL;
}

@end
