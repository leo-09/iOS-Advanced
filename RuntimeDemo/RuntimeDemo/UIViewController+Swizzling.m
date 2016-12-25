//
//  UIViewController+Swizzling.m
//  RuntimeDemo
//
//  Created by liyy on 2016/12/25.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "objc/runtime.h"

@implementation UIViewController (Swizzling)

+ (void) load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(xxx_viewWillAppear:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
//        Method originalMethod = class_getClassMethod(self, @selector(imageNamed:));
//        Method ourMethod = class_getClassMethod(self, @selector(AM_imageNamed:));
//        method_exchangeImplementations(originalMethod, ourMethod);
    });
    
}

- (void) xxx_viewWillAppear:(BOOL) animated {
    [self xxx_viewWillAppear:animated];
    
    NSLog(@"viewWillAppear: %@", self);
}

@end
