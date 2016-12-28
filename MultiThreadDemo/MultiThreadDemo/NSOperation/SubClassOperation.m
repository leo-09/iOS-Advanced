//
//  SubClassOperation.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/28.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "SubClassOperation.h"

@implementation SubClassOperation

- (void) main {
    for (int i = 0; i < 5; i++) {
        NSLog(@"SubClassOperation: %d, %@", i, [NSThread currentThread]);
    }
}

@end
