//
//  Algorithm.m
//  Algorithm
//
//  Created by xiaoyuan on 2021/4/21.
//  Copyright © 2021 xiaoyuan. All rights reserved.
//

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
