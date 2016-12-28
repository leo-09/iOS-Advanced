//
//  ConcurrenOperation.h
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/28.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock) (NSData *imageData);

@interface ConcurrenOperation : NSOperation

@property (nonatomic, copy) CompletionBlock comBlock;

@end
