//
//  StringSummation.m
//  Algorithm
//
//  Created by xiaoyuan on 2021/5/6.
//  Copyright © 2021 xiaoyuan. All rights reserved.
//

#import "StringSummation.h"
#include <string.h>

@implementation StringSummation

+ (NSInteger)sumWithString:(NSString *)str {
    NSInteger sum = 0;
    if (str.length == 0) {
        return sum;
    }
    for (NSInteger i = 0; i < str.length; i++) {
        NSString *current = [str substringWithRange:NSMakeRange(i, 1)];
        NSInteger num = [current integerValue];
        if (num > 0 && num <= 9 ) {
            sum += num;
        }
    }
    return sum;
}

+ (NSInteger)sumWithString1:(NSString *)str {
    NSInteger sum = 0;
    if (str.length == 0) {
        return sum;
    }
    NSInteger low = 0;
    NSInteger high = str.length - 1;
    while (low < high) {
        NSString *lowStr = [str substringWithRange:NSMakeRange(low, 1)];
        NSString *highStr = [str substringWithRange:NSMakeRange(high, 1)];
        NSInteger lowNum = [lowStr integerValue];
        NSInteger highNum = [highStr integerValue];
        if (lowNum > 0 && lowNum <= 9 ) {
            sum += lowNum;
        }
        if (highNum > 0 && highNum <= 9 ) {
            sum += highNum;
        }
        
        low += 1;
        high -= 1;
    }
    return sum;
}

+ (int)sumWithCString:(char *)cStr {
    long len = strlen(cStr);
    int sum = 0;
    if (len == 0) {
        return sum;
    }
    for (int i = 0; i < len; i++) {
        char current = cStr[i];
        if (current > '0' && current <= '9') {
            // 取出的字符char是ASSII码，不能直接相加，需要转换为整数
            int cInteger = atoi(&current);
            printf("current==%d\n", cInteger);
            sum += cInteger;
        }
    }
    return sum;
}

@end
