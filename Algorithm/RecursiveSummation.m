//
//  RecursiveSummation.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/10/12.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//  用递归写一个算法，计算从1到100的和

#import "RecursiveSummation.h"

@implementation RecursiveSummation

+ (int)sum:(int)value {
    if (value <= 0) {
        return 0;
    }
    int number = value;
    return value + [self sum:number - 1];
}

+ (void)test {
    int result = [self sum:100];
    printf("1到100的和为: %d\n", result);
}

@end
