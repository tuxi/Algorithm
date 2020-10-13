//
//  main.m
//  Algorithm
//
//  Created by xiaoyuan on 2020/8/31.
//  Copyright © 2020 xiaoyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharReverse.h"
#import "ReverseList.h"
#import "XYDictionary.h"
#import "LRUCache.h"
#import "DoubleLinkedList.h"
#import "RecursiveSummation.h"
#import "MACAddressGen.h"

void testCharReverse() {
    
    char str[] = "bakjecopo";
    printf("反转前：%s\n", str);
    [CharReverse reverseWithCString:str];
    printf("反转后：%s\n", str);
    
    NSString *strObj = [CharReverse reverseWithString:@"abcdefg"];
    NSLog(@"%@", strObj);
}

void testReverseList() {
    struct Node *list = [ReverseList constructList];
    printf("原始链表数据为\n");
    [ReverseList printList:list];
    printf("\n");
    // 全部逆序
    struct Node *newList = [ReverseList reverseList:list];
    printf("完整逆序后的链表数据为\n");
    [ReverseList printList:newList];
    
    // 部分逆序
    newList = [ReverseList reverseBetween:newList startIndex:1 endIndex:3];
    printf("逆序1到3的链表数据为\n");
    [ReverseList printList:newList];
    
    LinkedList *linkedList = [[LinkedList alloc] initWithArray:@[@1, @2, @3, @4, @5]];
    [linkedList reverse];
    [linkedList enumerateObjectsUsingBlock:^(struct Node * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id data = (__bridge id)(obj->data);
        NSLog(@"%@", data);
        if (idx == 3) {
            *stop = YES;
        }
    }];
}

void testXYDictionary() {
    XYDictionary *dict = [XYDictionary dictionary];
    [dict setObject:@"哈哈" forKey:@"孟"];
    [dict setObject:@"你好" forKey:@"孟"];
    [dict setObject:@123456 forKey:@"数字"];
    NSLog(@"%@",[dict objectForKey:@"孟"]);
    NSLog(@"%@",[dict objectForKey:@"数字"]);
}

void testLRUCache() {
    [[LRUCache new] test];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        testCharReverse();
//        testReverseList();
//        testXYDictionary();
        
//        testLRUCache();
//        [DoubleLinkedList test];
        
//        [RecursiveSummation test];
        
//        char imeiNum[15] = "358028050526077";
//        genIMEI(imeiNum, 1);
//        printf("\n");
//        for (int i = 0; i < strlen(imeiNum); i++) {
//            printf("%d", imeiNum[i]);
//        }
//        printf("\n");
        
        NSString *macAddress = [MACAddressGen genMacAddress];
        macAddress = [macAddress stringByReplacingOccurrencesOfString:@":" withString:@""].uppercaseString;
        if (macAddress.length > 0) {
    
            NSLog(@"随机生成的字符串：%@", [MACAddressGen md5:macAddress]);
        }
    
        __block NSString *appUrl = @"https://ax-log.duizhuang.com/index?a=1&active_id=53166&adspace_id=200042&agent=__UA__&androidid2=__ANDROIDID2__&branch=__BRANCH__&c=28&campaign_id=17203&creative_id=74987&devicetype=APP&e=click&gppid=__GPPID__&hiesid=PUB_0&idfa=__IDFA__&iesid=HUNANTV_0&imemd5=__IMEI__&ip=__IP__&mac=__MAC__&mn=__MN__&openudid=__OPENUDID__&os=__OS__&p=57&ts=__TS__&u=198&uuid=__UUID__&callback=http%3A%2F%2Fpy.da.mgtv.com%2Fdsp%2Fconv%3Fdid%3D2688%26idfa%3D__IDFA__%26mm%3D__IMEI__%26openudid%3D__OPENUDID__%26mac%3D__MAC__%26ip%3D__IP__%26uid%3D__UID__%26os%3D__OS__%26creative_id%3D74987%26convertid%3D4dc380ae34ccf88278d23b75ddab2ce3%26type%3D3%26event_type%3D3%26conv_time%3D__TRD_CONV_TIME__%26source%3D__TRD_SOURCE_%26clktime%3D%7Bclktime%7D%26regtime%3D%7Bregtime%7D";
        
        NSArray<NSString *> *replaceList = @[@"__UA__", @"__IMEI__", @"__IP__", @"__MAC__", @"__MN__", @"__OPENUDID__", @"__OS__", @"__TS_", @"__UUID__", @"__UID__", @"__GPPID__"];
        
        NSString * deviceModel=@"iPhone6s";
        // 9e3a1c33a96b3e8149d6a2563d309d4cdad9377b
        NSString * OpenUDID = [NSString stringWithFormat:@"9e3a1c33a96b%@09d4cdad9377b", [MACAddressGen getRandomStringWithNum:15]];
        NSString * BSSID=[MACAddressGen genMacAddress]; // 无线网的mac地址
        
        [replaceList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *value = @"";
            NSLog(@"替换_%@", obj);
            if (![appUrl containsString:obj]) {
                NSLog(@"不包含:%@", obj);
                return;
            }
            if ([obj isEqualToString:@"__UA__"]) { // User-Agent
//                UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
//                NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"] ?: @"";
//                value = userAgent;
                value = @"";
            }
            else if ([obj isEqualToString:@"__IMEI__"]) {
                
            }
            else if ([obj isEqualToString:@"__IP__"]) {
                value = @"100000";
            }
            else if ([obj isEqualToString:@"__MAC__"]) {
                NSString *str = [BSSID stringByReplacingOccurrencesOfString:@":" withString:@""].uppercaseString;
                if (str.length > 0) {
                    value = [MACAddressGen md5:str];
                }
            }
            else if ([obj isEqualToString:@"__MN__"]) {
                value = deviceModel;
            }
            else if ([obj isEqualToString:@"__OPENUDID__"]) {
                value = OpenUDID ?: @"";
            }
            else if ([obj isEqualToString:@"__OS__"]) {
                value = @"1";
            }
            else if ([obj isEqualToString:@"__TS__"]) {
                value = [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
            }
            else if ([obj isEqualToString:@"__UUID__"]) {
                value = [MACAddressGen getRandomStringWithNum:20];
            }
            else if ([obj isEqualToString:@"__UID__"]) {
                value = @"";
            }
            else if ([obj isEqualToString:@"__GPPID__"]) {
                value = @"";
            }
            if (value.length > 0) {
                appUrl = [appUrl stringByReplacingOccurrencesOfString:obj withString:value];
            }
        }];
        
        NSLog(@"%@", appUrl);
    }
    return 0;
}
