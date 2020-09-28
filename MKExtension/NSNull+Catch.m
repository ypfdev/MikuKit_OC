//
//  NSNull+Catch.m
//  MotionCamera
//
//  Created by SongYang on 2018/11/30.
//  Copyright © 2018 Galanz. All rights reserved.
//

#import "NSNull+Catch.h"
#import <objc/runtime.h>

//#ifndef DEBUG
@implementation NSNull (value)

- (id)lowercaseString{
    return @"";
}

- (float)floatValue{
    return 0;
}

-(double)doubleValue{
    return 0;
}

-(BOOL)boolValue{
    return NO;
}

- (NSInteger)integerValue{
    return 0;
}

- (BOOL)isEqualToString:(NSString *)aString{
    return [self.description isEqualToString:aString];
}

- (nullable id)objectForKeyedSubscript:(id)key{
    return nil;
}
@end


@implementation NSNumber (value)

- (BOOL)isEqualToString:(NSString *)aString{
    return [self.description isEqualToString:aString];
}

@end


@implementation NSString (OutOfBounds)

+ (void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(NSString.class, @selector(substringFromIndex:)), class_getInstanceMethod(NSString.class, @selector(ex_substringFromIndex:)));
    method_exchangeImplementations(class_getInstanceMethod(NSString.class, @selector(substringWithRange:)), class_getInstanceMethod(NSString.class, @selector(ex_substringWithRange:)));
}

- (NSString *)ex_substringFromIndex:(NSUInteger)from{
    if (from > self.length) {
        NSArray* arr = [NSThread callStackSymbols];
        NSAssert(from < self.length,[arr description]);
    }
    
    return [self ex_substringFromIndex:from];
}


- (NSString *)ex_substringWithRange:(NSRange)range{
    if (range.length <= self.length && range.location + range.length <= self.length) {
        NSString* string = [self ex_substringWithRange:range];
        return string;
    }
    return @"";
}

@end


@implementation NSArray(OutOfBounds)
+ (void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:)), class_getInstanceMethod(NSArray.class, @selector(ex_objectAtIndexedSubscript:)));
    
    method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"__NSPlaceholderArray"), @selector(initWithObjects:count:)), class_getInstanceMethod(NSArray.class, @selector(ex_initWithObjects:count:)));
}

- (id)objectForKeyedSubscript:(id)sc{
    return nil;
}

- (id)ex_objectAtIndexedSubscript:(NSUInteger)idx{
    if (idx + 1 > self.count) {
//        NSArray* arr = [NSThread callStackSymbols];
//        NSString* reason = [NSString stringWithFormat:@"index:%zd out of bounds:%zd",idx,self.count];
//        PFLog(@"%@\n%@",reason,self);
//        NSAssert(idx + 1 <= self.count,[arr description]);
        return nil;
    }
    return [self ex_objectAtIndexedSubscript:idx];
}

- (instancetype)ex_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    if (objects != NULL) {
        for (int i = 0; i < cnt; i++) {
            if (objects[i] == nil) {
                
                NSString* prefix = @"\nobjects:";
                for (int j = 0; j < cnt; j++) {
                    if (*(objects + j) != nil) {
                        prefix = [prefix stringByAppendingString:[[*(objects + j) description] stringByAppendingString:@","]];
                    }
                }
                
                NSString* string = [NSString stringWithFormat:@"\ninsert nil object at index:\"%d\"\n objects:%@ \ncall stack:%@\n",i,prefix,[[NSThread callStackSymbols] description]];
                NSAssert(objects[i],string);
            }
        }
    }
    
    return [self ex_initWithObjects:objects count:cnt];
}

@end

@implementation NSDictionary (InsertNilValue)
+ (void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(NSClassFromString(@"__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:)), class_getInstanceMethod(NSDictionary.class, @selector(initWithObjects_ex:forKeys:count:)));
}

- (instancetype)initWithObjects_ex:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    if (objects != NULL) {
        for (int i = 0; i < cnt; i++) {
            if (objects[i] == nil || keys[i] == nil) {
                NSString* string = [NSString stringWithFormat:@"\ninsert object:\"%@\" for key:\"%@\"\ncall stack:%@",objects[i],keys[i],[[NSThread callStackSymbols] description]];
                NSAssert(objects[i] && keys[i],string);
            }
        }
    }
    
    self = [self initWithObjects_ex:objects forKeys:keys count:cnt];
    
    return self;
}

@end
