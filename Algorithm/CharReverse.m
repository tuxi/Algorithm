//
//  CharReverse.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/8/31.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import "CharReverse.h"
#include <string.h>

@implementation CharReverse

+ (void)reverseWithCString:(char *)cString {
    // 指向第一个字符串
    char *begin = cString;
    // 指向最后一个字符串
    char *end = cString + strlen(cString) - 1;
    
    while (begin < end) {
        // 交换两个字符，并移动指针
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
}

+ (void)reverseWithCString1:(char *)cString {
    
    char *begin = cString;
    char *end = cString + strlen(cString) - 1;
    
    while (begin < end) {
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
}

+ (NSString *)reverseWithString:(NSString *)string {
    NSMutableString *mutableStr = [NSMutableString string];
    for (NSInteger i = string.length; i > 0; i--) {
        [mutableStr appendString:[string substringWithRange:NSMakeRange(i - 1, 1)]];
    }
    return mutableStr;
}

@end
