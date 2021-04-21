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

@property (readonly) NSUInteger count;

+ (instancetype)dictionary;

- (void)setObject:(id)obj forKey:(NSString *)key;
- (nullable id)objectForKey:(NSString *)key;
- (nullable id)removeObjectForKey:(NSString *)aKey;

@end

NS_ASSUME_NONNULL_END
