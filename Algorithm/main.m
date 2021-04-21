//
//  main.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/8/31.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharReverse.h"
#import "ReverseList.h"
#import "XYDictionary.h"
#import "LRUCache.h"
#import "DoubleLinkedList.h"
#import "RecursiveSummation.h"
#import "MACAddressGen.h"
#import "ObjcLRLCache.h"

void testCharReverse() {
    
    char str[] = "bakjecopo";
    printf("反转前：%s\n", str);
    [CharReverse reverseWithCString:str];
    printf("反转后：%s\n", str);
    
    NSString *strObj = [CharReverse reverseWithString:@"abcdefg"];
    NSLog(@"%@", strObj);
}

void testReverseList() {
    struct Node *list = [ReverseList constructList];
    printf("原始链表数据为\n");
    [ReverseList printList:list];
    printf("\n");
    // 全部逆序
    struct Node *newList = [ReverseList reverseList:list];
    printf("完整逆序后的链表数据为\n");
    [ReverseList printList:newList];
    
    // 部分逆序
    newList = [ReverseList reverseBetween:newList startIndex:1 endIndex:3];
    printf("逆序1到3的链表数据为\n");
    [ReverseList printList:newList];
    
    LinkedList *linkedList = [[LinkedList alloc] initWithArray:@[@1, @2, @3, @4, @5]];
    [linkedList reverse];
    [linkedList enumerateObjectsUsingBlock:^(struct Node * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id data = (__bridge id)(obj->data);
        NSLog(@"%@", data);
        if (idx == 3) {
            *stop = YES;
        }
    }];
}

void testXYDictionary() {
    XYDictionary *dict = [XYDictionary dictionary];
    [dict setObject:@"哈哈" forKey:@"孟"];
    [dict setObject:@"你好" forKey:@"孟"];
    [dict setObject:@123456 forKey:@"数字"];
    NSLog(@"%@",[dict objectForKey:@"孟"]);
    NSLog(@"%@",[dict objectForKey:@"数字"]);
    NSLog(@"字典数量: %ld", dict.count);
    NSLog(@"%@", [dict removeObjectForKey:@"孟"]);
    NSLog(@"%@", [dict removeObjectForKey:@"数字"]);
    NSLog(@"字典数量: %ld", dict.count);
}

void testLRUCache() {
    [[LRUCache new] test];
    
    ObjcLRLCache *cache = [[ObjcLRLCache alloc] initWithMaxSize:10];
    [cache put:@"apple" value:@1000];
    [cache put:@"xyy" value:@"11000"];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        testCharReverse();
//        testReverseList();
        testXYDictionary();
        
        testLRUCache();
//        [DoubleLinkedList test];
        
//        [RecursiveSummation test];
        
//        char imeiNum[15] = "358028050526077";
//        genIMEI(imeiNum, 1);
//        printf("\n");
//        for (int i = 0; i < strlen(imeiNum); i++) {
//            printf("%d", imeiNum[i]);
//        }
//        printf("\n");
    }
    return 0;
}
