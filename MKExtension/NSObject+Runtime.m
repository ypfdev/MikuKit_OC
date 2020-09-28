//
//  NSObject+Runtime.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/9/9.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "NSObject+Runtime.h"
#import "objc/runtime.h"

@implementation NSObject (Runtime)

- (NSArray<NSString *> *)mk_propertyNameList {
    NSMutableArray<NSString *> *propertyNameList = [NSMutableArray new];
    // 获取属性列表
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        const char *cStr = property_getName(propertyList[i]);
        NSString *propertyName = [NSString stringWithUTF8String:cStr];
        if (propertyName) {
            [propertyNameList addObject:propertyName];
            NSLog(@"property ==> %@", propertyName);
        }
    }
    return propertyNameList;
}

- (void)mk_printPropertyValueList {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(unsigned int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        //kvc读值
        NSString *value = [[self class] valueForKey:key];
        NSLog(@"%@->%@",key,value);
    }
}

- (void)mk_printCallStack {
    NSArray<NSString *> *symbols = [NSThread callStackSymbols];
    if ([symbols count] > 1) {
        for (unsigned int i = 0; i < symbols.count; i++) {
            NSLog(@"mytest======<%@ %p> %@ - caller: %@ ", [self class], self, NSStringFromSelector(_cmd),[symbols objectAtIndex:i]);
        }
    } else {
        NSLog(@"mytest======<%@ %p> %@", [self class], self, NSStringFromSelector(_cmd));
    }
}

- (void)mk_printMethodList {
    unsigned int count;
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        SEL nameSel = method_getName(methodList[i]);
        NSString *name = [NSString stringWithCString:sel_getName(nameSel) encoding:NSUTF8StringEncoding];
        NSString *str = [NSString stringWithCString:method_getTypeEncoding(methodList[i]) encoding:NSUTF8StringEncoding];
        NSLog(@"方法名 ==> %@\n属性 ==> %@", name, str);
    }
}

@end
