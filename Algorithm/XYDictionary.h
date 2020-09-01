//
//  XYDictionary.h
//  Algorithm
//
//  Created by xiaoyuan on 2020/9/1.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYDictionary : NSObject

+ (instancetype)dictionary;

- (void)setObject:(id)obj forKey:(NSString *)key;
- (nullable NSObject *)objectForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
