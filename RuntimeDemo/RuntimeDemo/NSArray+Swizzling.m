//
//  NSArray+Swizzling.m
//  RuntimeDemo
//
//  Created by liyy on 2016/12/25.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "NSArray+Swizzling.h"
#import "objc/runtime.h"

@implementation NSArray (Swizzling)

+ (void) load {
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(swizzling_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (id) swizzling_objectAtIndex:(NSUInteger) index {
    if ((self.count-1) < index) {
        @try {
            return [self swizzling_objectAtIndex:index];
        } @catch (NSException *exception) {
            // 打印崩溃信息
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            
        }
    } else {
        return [self swizzling_objectAtIndex:index];
    }
}

@end
