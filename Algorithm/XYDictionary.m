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
@property (nonatomic, readwrite) NSUInteger count;

- (instancetype)initWithKey:(NSString *)key value:(id)value;

@end

@implementation XYDictionary {
    // 数据
    LinkedArray *_keyValues[999];
}

+ (instancetype)dictionary {
    return [self new];
}

- (void)setObject:(id)obj forKey:(NSString *)key {
    if (!key.length || !obj) {
        return;
    }
    NSUInteger index = [self _indexOfKey:key];
    LinkedArray *linkArray = _keyValues[index];
    // 字典中解决hash冲突
    // 可能存在不同的key的hash值相同，为了解决冲突，设计每个hash对应一个linkArray数组，也就是将相同hash的key和value存储在一个linkArray中，查找时根据key得到hash后，先查找到linkArray，然后再根据key在linkArray中查找对应的value，即可解决hash冲突问题
    if (linkArray) {
        // 如果存在链表数组
        for (NSInteger i = 0; i < linkArray.count; i++) {
            KeyValueCache *keyValue = (KeyValueCache *)[linkArray objectAtIndex:i];
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
        _keyValues[index] = linkArray;
    }
    // 更新数量
    _count += 1;
}

- (nullable id)objectForKey:(NSString *)key {
    if (!key.length) {
        return nil;
    }
    
    NSUInteger index = [self _indexOfKey:key];
    
    LinkedArray *linArray = _keyValues[index];
    
    if (!linArray) {
        return nil;
    }
    for (NSInteger i = 0; i < linArray.count; i++) {
        KeyValueCache *keyValue = (id)[linArray objectAtIndex:i];
        if ([keyValue.key isEqualToString:key]) {
            return keyValue.value;
        }
    }
    return nil;
}

- (nullable id)removeObjectForKey:(NSString *)aKey {
    if (!aKey.length) {
        return nil;
    }
    NSUInteger index = [self _indexOfKey:aKey];
    LinkedArray *linArray = _keyValues[index];
    if (!linArray) {
        return nil;
    }
    KeyValueCache *cache = nil;
    NSInteger indexOfCache = NSNotFound;
    for (NSInteger i = 0; i < linArray.count; i++) {
        KeyValueCache *keyValue = (id)[linArray objectAtIndex:i];
        if ([keyValue.key isEqualToString:aKey]) {
            cache = keyValue;
            indexOfCache = i;
            break;
        }
    }
    if (indexOfCache != NSNotFound) {
        // 从链表数组中移除当前keyvalue
        [linArray removeAtIndex:indexOfCache];
        // 当链表数组为空时，从_keyValues中移除空
        if (linArray.count == 0) {
            _keyValues[index] = nil;
        }
        _count -= 1;
        return cache.value;
    }
    
    return nil;
}


- (NSUInteger)_indexOfKey:(NSString *)key {
    // 获取hashCode
    NSUInteger hash = key.hash;
    // 默认一个对象占8个字节
//    NSUInteger index = hash & (sizeof(_keyValues) / 8);
    NSUInteger index = hash % (sizeof(_keyValues) / 8);
    return index;
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
