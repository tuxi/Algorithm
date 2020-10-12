//
//  HeshFind.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/8/31.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//  查找第一个只出现一次的字符

#import "HeshFind.h"

@implementation HeshFind

+ (char)findFirstChar:(char *)str {
    char result = '\0';
    // 定义一个数组，用来存储各个字母出现的次数
    int array[256];
    // 对数组进行初始化操作
    for (int i = 0; i < 256; i++) {
        array[i] = 0;
    }
    
    // 定义一个指针，指向当前字符串头部
    char *p = str;
    // 遍历每个字符
    while (*p != '\0') {
        // 在字母对应存储位置，进行出现次数+1的操作
        array[*(p++)]++;
    }
    
    // 将p指针重新指向字符串头部
    p = str;
    // 遍历每个字母出现的次数
    while (*p != '\0') {
        // 遍历第一个出现次数为1的字符，打印结果
        if (array[*p] == 1) {
            result = *p;
            break;
        }
        // 反之继续向后遍历
        p++;
    }
    return result;
}

@end
