//
//  MACAddressGen.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/10/13.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import "MACAddressGen.h"
#import<CommonCrypto/CommonDigest.h>

@implementation MACAddressGen
+ (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

+ (int)randomDigit:(int)max
{
    int generated;
    
    generated = (random() % max);
    return generated;
}

static NSArray *MACAddressCharArr() {
    // 存储MAC address 中用到的字符
    static NSArray *array = nil;
    if (array == nil) {
        array = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"A", @"B", @"C", @"D", @"E", @"F"];
    }
    return array;
}

+ (NSString *)hexPair
{
 
    // 将数组array里面的对象乱序
    NSArray *result = [MACAddressCharArr() sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];  // compare字符串的比较(name为NSString)
        } else {
            return [str2 compare:str1];
        }
    }];
    
    NSString *temp1 = [result componentsJoinedByString:@""];
    NSString *temp2;
    char c1, c2;
    
    c1 = [temp1 characterAtIndex:[self randomDigit:16]];
    c2 = [temp1 characterAtIndex:[self randomDigit:16]];
    
    temp2 = [NSString stringWithFormat:@"%c%c", c1, c2];
    
    return temp2;
}

+ (NSString *)genMacAddress
{
    NSString *tempPair;
    NSString *tempAddress;
    NSString *macAddress;
    int i;
    
    tempAddress = [NSString stringWithString:[self hexPair]];
    
    for (i = 0; i < 5; i++)
    {
        tempPair = [NSString stringWithFormat:@":%@", [self hexPair]];
        NSLog(@"tempPair = %@", tempPair);
        tempAddress = [tempAddress stringByAppendingString:tempPair];
    }
    macAddress = tempAddress;
    return macAddress;
}

+ (NSString *) md5:(NSString *) input {
    if (input.length == 0) {
        return @"";
    }
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
@end
