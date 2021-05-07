//
//  Algorithm.m
//  Algorithm
//
//  Created by xiaoyuan on 2021/4/21.
//  Copyright © 2021 xiaoyuan. All rights reserved.
//  https://cuijiahua.com/blog/2017/12/algorithm_2.html

#import "Algorithm.h"

@implementation Algorithm

+ (NSInteger)binarySearchWithValue:(NSInteger)value array:(NSArray<NSNumber *> *)array {
//    1.设数组的第一项索引为low，最后一项索引为hight，中间项索引为mid（这里我用“mid”表示中间项的值，“low”表示第一项的值，"high"表示最后一项的值）；
//
//            2.比较“mid”与item；
//
//            3.若“mid”>item,则表明item位于数组的前半部分，所以设置high的值为mid-1；
//
//            4.若“mid”<item，则表明item位于数组的后半部分，所以设置low的值为mid+1;
//
//            5.若high>low，设置mid为(low+hight)/2（即low到high的中间项），返回步骤2；
//
//            6.直到查到了一项与item相等，或者high<low为止；
//
//            7.判断“mid”与item是否相等，若相等则表明查找成功，否则表明查找失败（即未找到）。
    
    NSInteger index = NSNotFound;
    NSInteger low = 0;
    NSInteger high= array.count-1;
    while (low < high) {
        
        NSInteger mid = (low+high) / 2;
        NSNumber *tmpNum = [array objectAtIndex:mid];
        int tmpInt = [tmpNum intValue];
        if (value < tmpInt) {
            high = mid-1;
        } else if (value > tmpInt) {
            low = mid+1;
        } else {
            index = mid;
            break;
        }
    }
    return index;
}

+ (NSArray<NSNumber *> *)bubbleSortWithArray:(NSArray<NSNumber *> *)array {
    // 冒泡排序是一种交换排序
    // 它重复地走访要排序的数列，一次比较两个元素，如果他们的顺序错误就把他们交换过来。走访数列的工作是重复地进行直到没有再需要交换，也就是说该数列已经排序完成。
    if (array.count == 0) {
        return nil;
    }
    NSMutableArray *arrayM = [array mutableCopy];
    NSNumber *temp = nil;
    for (NSInteger i = 0; i < arrayM.count - 1; ++i) {
        // 从后向前依次的比较相邻两个数的大小
        for (NSInteger j = 0; j < arrayM.count - 1; j++) {
            // 如果后面的元素小，则交换他们的位置
            if ([arrayM[j + 1] integerValue] < [arrayM[j] integerValue]) {
                temp = arrayM[j + 1];
                arrayM[j + 1] = arrayM[j];
                arrayM[j] = temp;
            }
        }
    }
    return arrayM;
}
//
+ (NSArray<NSNumber *> *)insertSortWithArray:(NSArray<NSNumber *> *)array {
    if (array.count == 0) {
        return array;
    }
    NSMutableArray *arrayM = [array mutableCopy];
    
    // 第1个数肯定是有序的，从第2个数开始遍历，依次插入有序序列
    for (int i = 1; i < array.count; i++) {
        // 取出第i个数，和前i-1个数比较后，插入合适位置
        NSInteger temp = [arrayM[i] integerValue];
        // 因为前i-1个数都是从小到大的有序序列，所以只要当前比较的数arrayM[j]比temp大，就把这个数后移一位
        int j = i - 1;
        for (j; j >= 0 && [arrayM[j] integerValue] > temp; j--) {
            arrayM[j + 1] = arrayM[j];
        }
        arrayM[j + 1] = @(temp);
    }
    return arrayM;
}



+ (Class)commonClass:(Class)classA addClass:(Class)classB {
    // 获取一个类的所有父类
    NSArray * (^getSuperClasses)(Class) = ^(Class clas){
        if (clas == nil) {
            return @[];
        }
        
        NSMutableArray *result = [NSMutableArray array];
        Class temp = clas;
        while (temp) {
            [result addObject:temp];
            temp = [temp superclass];
        }
        return (NSArray *)[result copy];
    };
    
    NSArray *arrayA = getSuperClasses(classA);
    NSArray *arrayB = getSuperClasses(classB);
    NSSet *set = [NSSet setWithArray:arrayB];
    for (NSInteger i = 0; i < arrayA.count; i++) {
        Class targetClass = arrayA[i];
        if ([set containsObject:targetClass]) {
            return  targetClass;
        }
    }
    return  nil;
}

@end
