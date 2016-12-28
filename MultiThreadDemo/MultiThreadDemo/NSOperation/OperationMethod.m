//
//  OperationMethod.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/28.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "OperationMethod.h"
#import "SubClassOperation.h"

static OperationMethod *instance = nil;

@implementation OperationMethod

+ (instancetype) shareOperationManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OperationMethod alloc] init];
    });
    
    return instance;
}

#pragma mark NSoperation任务

// operation创建方式invocationOperation
- (void) invocationOperation {
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    op.completionBlock = ^{
        NSLog(@"invocationOperation 任务完成后回调block");
    };
    [op start];
}

// operation创建方式blockOperation
- (void) blockOperation {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation: %@", [NSThread currentThread]);
    }];
    op.completionBlock = ^{
        NSLog(@"blockOperation 任务完成后回调block");
    };
    [op start];
}

// blockoperation添加任务
- (void) blockOperaionAddTask {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperaionAddTask: %@", [NSThread currentThread]);
    }];
    
    for (int i = 0; i < 5; i++) {
        [op addExecutionBlock:^{
            NSLog(@"blockOperaionAddTask：%d，%@", i,[NSThread currentThread]);
        }];
    }
    
    [op start];
}

// 子类任务
- (void) subClassOperation {
    SubClassOperation *op =[[SubClassOperation alloc] init];
    [op start];
}

#pragma mark 任务加入NSoperation队列
// 添加operationToQueue
- (void) addOperationToQueue {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2. 创建操作
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run2) object:nil];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"addOperationToQueue--op2: %d, %@", i,[NSThread currentThread]);
        }
    }];
    
    // 3. 添加操作到队列中：addOperation:
    [queue addOperation:op1];
    [queue addOperation:op2];
}

- (void) addOperaionWithBlockToQueue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 5;
    
    for (int i = 0; i < 5; i++) {
        [queue addOperationWithBlock:^{
            NSLog(@"addOperaionWithBlockToQueue--op2: %d, %@", i,[NSThread currentThread]);
        }];
    }
}

//操作依赖
- (void) operationDependency {
    NSMutableArray *array = [NSMutableArray array];
    
    // 创建任务
    for (int i = 0; i < 10; i++) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"operationDependency ---- 第%d个任务: %@",i,[NSThread currentThread]);
        }];
        op.name = [NSString stringWithFormat:@"op%d", i];
        [array addObject:op];
    }
    
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.name = @"queue";
    
    // 设置依赖 可以跨队列依赖。
    for (int i = 0; i < array.count-1; i++) {
        // 依次依赖,下面相当于同步执行
        NSBlockOperation *op1 = [array objectAtIndex:i];
        NSBlockOperation *op2 = [array objectAtIndex:i+1];
        [op2 addDependency:op1];
        
        // 修改 Operation 在队列中的优先级
        if (i == 3) {
            [op1 setQueuePriority:NSOperationQueuePriorityHigh];
        }
        
        //删除依赖
        if (i == 6) {
            [op2 removeDependency:op1];
        }
    }
    
    // 需求：第8个任务完成后取消队列任务
    NSBlockOperation *op1 = [array objectAtIndex:7];
    op1.completionBlock = ^{
        [queue cancelAllOperations];// 取消队列中未执行的所有任务
    };
    
    // 添加任务到队列中
    [queue addOperations:array waitUntilFinished:NO];
}

#pragma 实际操作的方法

- (void)run{
    NSLog(@"------%@", [NSThread currentThread]);
}

- (void)run2{
    for (int i = 0; i < 5; i++) {
        NSLog(@"op1---->%d-----%@",i, [NSThread currentThread]);
    }
}

@end
