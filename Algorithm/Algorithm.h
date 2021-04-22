//
//  Algorithm.h
//  Algorithm
//
//  Created by xiaoyuan on 2021/4/21.
//  Copyright © 2021 xiaoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Algorithm : NSObject

// 对已排好序的数组，使用二分查找value所在数组的index
+ (NSInteger)binarySearchWithValue:(NSInteger)value array:(NSArray<NSNumber *> *)array;

// 寻找两个Class的最近的公共父类
+ (Class)commonClass:(Class)classA addClass:(Class)classB;

@end

NS_ASSUME_NONNULL_END
