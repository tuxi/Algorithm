//
//  XYDictionary.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/9/1.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import "XYDictionary.h"
#import "LinkedArray.h"

@interface KeyValueCache : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) id value;

- (instancetype)initWithKey:(NSString *)key value:(id)value;

@end

@implementation XYDictionary {
    LinkedArray *_keyValues[999];
}

+ (instancetype)dictionary {
    return [self new];
}

- (void)setObject:(id)obj forKey:(NSString *)key {
    // 获取hashCode
    NSUInteger hash = key.hash;
    // 默认一个对象占8个字节
    NSUInteger realCode = hash % (sizeof(_keyValues) / 8);
    LinkedArray *linkArray = _keyValues[realCode];
    
    if (linkArray) {
        // 如果存在链表数组
        for (NSInteger index = 0; index < linkArray.count; index++) {
            KeyValueCache *keyValue = (KeyValueCache *)[linkArray objectAtIndex:index];
            if ([keyValue.key isEqualToString:key]) {
                // 存在相同的key 更新value
                keyValue.value = obj;
                return;
            }
        }
        
        // 创建新的键值对存储
         KeyValueCache *keyValue = [[KeyValueCache alloc] initWithKey:key value:obj];
        [linkArray appendObject:keyValue];
    }
    else {
        // 不存在链表数组
        LinkedArray *linkArray = [LinkedArray array];
        KeyValueCache *keyValue = [[KeyValueCache alloc] initWithKey:key value:obj];
        [linkArray appendObject:keyValue];
        _keyValues[realCode] = linkArray;
    }
}

- (NSObject *)objectForKey:(NSString *)key {
    if (!key.length) {
        return nil;
    }
    
    // 获取hashCode
    NSUInteger hash = key.hash;
    NSUInteger readCode = hash % (sizeof(_keyValues) / 8);
    
    LinkedArray *linArray = _keyValues[readCode];
    
    if (linArray) {
        for (NSInteger index = 0; index < linArray.count; index++) {
            KeyValueCache *keyValue = (id)[linArray objectAtIndex:index];
            if ([keyValue.key isEqualToString:key]) {
                return keyValue.value;
            }
        }
    }
    return nil;
}

@end

@implementation KeyValueCache

- (instancetype)initWithKey:(NSString *)key value:(id)value {
    if (self = [super init]) {
        self.value = value;
        self.key = key;
    }
    return self;
}

@end
