//
//  MACAddressGen.h
//  Algorithm
//
//  Created by xiaoyuan on 2020/10/13.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MACAddressGen : NSObject
// 随机生产mac地址
+ (NSString *)genMacAddress;
// 随机生成字母和数字组合的字符串，长度为num
+ (NSString *)getRandomStringWithNum:(NSInteger)num;
+ (NSString *) md5:(NSString *) input;
@end

NS_ASSUME_NONNULL_END
