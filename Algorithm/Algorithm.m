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

/*
 快速排序的基本思想是通过一趟快速排序，将要排序的数据分割成独立的两部分，其中一部分的所有数据比另外一部分的所有数据都要小，然后再按此方法递归地对这两部分数据分别进行快速排序。如此一直进行下去，直到排序完成。

 快速排序实际上是冒泡排序的一种改进，是冒泡排序的升级版。这种改进就体现在根据分割序列的基准数，跨越式地进行交换。正是由于这种跨越式，使得元素每次移动的间距变大了，而不像冒泡排序那样一格一格地“爬”。快速排序是一次跨多格，所以总的移动次数就比冒泡排序少很多。

 但是快速排序也有一个问题，就是递归深度的问题。调用函数要消耗资源，递归需要系统堆栈，所以递归的空间消耗要比非递归的空间消耗大很多。而且如果递归太深的话会导致堆栈溢出，系统会“撑”不住。快速排序递归的深度取决于基准数的选择，比如下面这个序列：

 5  1  9  3  7  4  8  6  2

 5 正好处于 1~9 的中间，选择 5 作基准数可以平衡两边的递归深度。可如果是：

 1  5  9  3  7  4  8  6  2

 选择 1 作为基准数，那么递归深度就全部都加到右边了。如果右边有几万个数的话则系统直接就崩溃了。所以需要对递归深度进行优化。怎么优化呢？就是任意取三个数，一般是取序列的第一个数、中间数和最后一个数，然后选择这三个数中大小排在中间的那个数作为基准数，这样起码能确保获取的基准数不是两个极端。
 */
+ (void)quickSortWithArray:(NSMutableArray<NSNumber *> *)array {
    [self _quickSortWithArray:array left:0 right:array.count - 1];
}

+ (void)_quickSortWithArray:(NSMutableArray<NSNumber *> *)array left:(NSInteger)left right:(NSInteger)right {
    NSInteger i = left;
    NSInteger j = right;
    // key 是作为基准数，递归深度取决于key，当key恰好是左右所有元素的中间数时，则可以很好的平衡两边的递归深度，当key正好处于所有元素的最小数时，则递归的深度就全部加到右边了。
    NSNumber *key = array[left];
    
    if (left >= right) {
        // 当left >= left 说明排序结束了
        return;
    }
    while (left < right) { // 该while循环结束一次表示比较了一轮
        while (left < right && key.integerValue <= array[right].integerValue) {
            --right; // 向前寻找
        }
        if (key.integerValue > array[right].integerValue) {
            array[left] = array[right]; //直接赋值, 不用交换
            ++left;
        }
        while (left < right && key.integerValue >= array[left].integerValue) {
            ++left; // 向右寻找
        }
        if (key.integerValue < array[left].integerValue) {
            array[right] = array[left]; //直接赋值, 不用交换
            --right;
        }
    }
    array[left] = key; //查找完一轮后key值归位, 不用比较一次就互换一次。此时key值将序列分成左右两部分
    [self _quickSortWithArray:array left:i right:left - 1]; //用同样的方式对分出来的左边的部分进行同上的做法
    [self _quickSortWithArray:array left:left + 1 right:j]; //用同样的方式对分出来的右边的部分进行同上的做法
}

//void QuickSort(int *a, int low, int high)
//{
//    int i = low;
//    int j = high;
//    int key = a[low];
//    if (low >= high) //如果low >= high说明排序结束了
//    {
//        return ;
//    }
//    while (low < high) //该while循环结束一次表示比较了一轮
//    {
//        while (low < high && key <= a[high])
//        {
//            --high; //向前寻找
//        }
//        if (key > a[high])
//        {
//            a[low] = a[high]; //直接赋值, 不用交换
//            ++low;
//        }
//        while (low < high && key >= a[low])
//        {
//            ++low; //向后寻找
//        }
//        if (key < a[low])
//        {
//            a[high] = a[low]; //直接赋值, 不用交换
//            --high;
//        }
//    }
//    a[low] = key; //查找完一轮后key值归位, 不用比较一次就互换一次。此时key值将序列分成左右两部分
//    QuickSort(a, i, low-1); //用同样的方式对分出来的左边的部分进行同上的做法
//    QuickSort(a, low+1, j); //用同样的方式对分出来的右边的部分进行同上的做法
//}
//

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
