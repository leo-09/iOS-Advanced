//
//  SerialOperation.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/28.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "SerialOperation.h"

@implementation SerialOperation

- (void) main {
    @autoreleasepool {
        if (self.isCancelled) {
            return;
        }
        
        NSURL *url = [NSURL URLWithString:@"https://p1.bpimg.com/524586/475bc82ff016054ds.jpg"];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
        
        if (!imageData) {
            imageData = nil;
        }
        
        [self performSelectorOnMainThread:@selector(completionAction:) withObject:imageData waitUntilDone:NO];
    }
}

- (void) completionAction:(NSData *)data {
    if (self.comBlock) {
        self.comBlock(data);
    }
}

@end
