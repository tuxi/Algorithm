//
//  Blocks.m
//  Algorithm
//
//  Created by xiaoyuan on 2021/4/23.
//  Copyright © 2021 xiaoyuan. All rights reserved.
//

#import "Blocks.h"

typedef NSString *(^StringBlock)(NSString *num);

@interface Blocks ()

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) StringBlock block1;
@property (nonatomic, copy) int (^block2)(int num);
@property (nonatomic, assign) int var;

@end

@implementation Blocks
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.var = 10;
        [self testBlock2];
        [self test3];
    }
    return self;
}

- (void)testBlock1 {
    self.array = [NSMutableArray arrayWithObject:@"object"];
    __weak NSArray *weakArray = _array;
    self.block1 = ^NSString *(NSString *num) {
        return  [NSString stringWithFormat:@"hello_%@", weakArray[0]];
        // 直接使用_array会产生循环引用
//        return  [NSString stringWithFormat:@"hello_%@", _array[0]];
    };
    
    NSLog(@"_block1() = %@", _block1(@"hello"));
}

- (void)testBlock2 {
    // 在mrc下以下代码，不会产生循环引用，
    // 在arc下会产生循环引用，由于blockSelf指向的原来的对象，所以会产生大环引用
//    __block Blocks *blockSelf = self;
//    _block2 = ^int(int num){
//        return num * blockSelf.var;
//    };
//    NSLog(@"_block2(3) = %d", _block2(3));
//
    
    // 通过断环的方式，断开__block变量的强持有
    __block Blocks *blockSelf = self;
    _block2 = ^int(int num){
        int result = num * blockSelf.var;
        // 通过断环的方式，解决循环引用，有个弊端：如果很长一段时间不掉用此block，也是无法解决，比如这段代码执行时机不确定
        // 也就是说，只有block块内的代码被执行时，才会解决循环引用
        blockSelf = nil;
        return result;
    };
    NSLog(@"_block2(3) = %d", _block2(3));
    
    // 模拟block执行时机不确定，此时还是无法解决循环引用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 通过断环的方式，断开__block变量的强持有
        __block Blocks *blockSelf = self;
        _block2 = ^int(int num){
            int result = num * blockSelf.var;
            // 通过断环的方式，解决循环引用，有个弊端：如果很长一段时间不掉用此block，也是无法解决，比如这段代码执行时机不确定
            // 也就是说，只有block块内的代码被执行时，才会解决循环引用
            blockSelf = nil;
            return result;
        };
        NSLog(@"_block2(3) = %d", _block2(3));
    });
}

- (void)test3 {
    {
        // __NSGlobalBlock__ 全局区block, 针对没有捕获自动变量的block来说，虽然用clang的rewrite-objc转化后的代码中仍显示_NSConcretStackBlock，但是实际上不是这样的。
        int(^block)(int count) = ^(int count) {
            return count;
        };
        block(2);
    }
    
    {
        // __NSMallocBlock__ 堆区block,
        int num = 4;
        int(^block)(int count) = ^(int count) {
            return count + num;
        };
        block(2);
    }
    
    {
        // __NSGlobalBlock__ 全局区block, 捕获的是静态变量或全局变量时
        static int num = 4;
        int(^block)(int count) = ^(int count) {
            return count + num;
        };
        block(2);
    }
    
    {
        // __NSMallocBlock__ 堆区block
        __block int num = 4;
        int(^block)(int count) = ^(int count) {
            return count + num;
        };
        num = 20;
        block(2);
    }
    
    {
        static int num = 4;
        int(^block)(int count) = ^(int count) {
            
            return count + num;
        };
        num = 20;
        NSLog(@"block(2) = %d", block(2));
    }
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end
