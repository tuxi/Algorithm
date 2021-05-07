//
//  StringSummation.h
//  Algorithm
//
//  Created by xiaoyuan on 2021/5/6.
//  Copyright © 2021 xiaoyuan. All rights reserved.
//  将字符串中的数字提取并相加

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StringSummation : NSObject

+ (NSInteger)sumWithString:(NSString *)str;
+ (NSInteger)sumWithString1:(NSString *)str;
+ (int)sumWithCString:(char *)cStr;
@end

NS_ASSUME_NONNULL_END
