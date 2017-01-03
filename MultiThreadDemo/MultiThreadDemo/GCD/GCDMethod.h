//
//  GCDMethod.h
//  MultiThreadDemo
//
//  Created by liyy on 2017/1/3.
//  Copyright © 2017年 liyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDMethod : NSObject

+ (GCDMethod *)shareGCDMethodManager;

//串行队列同步
- (void)serialQueueSyncMethod;
//串行队列异步
- (void)serialQueueAsyncMethod;

//并行队列同步
- (void)concurrentQueueSyncMethod;
//并行队列异步
- (void)concurrentQueueAsyncMethod;


//全局队列同步
- (void)globalSyncMethod;
//全局队列异步
- (void)globalAsyncMethod;

//主队列同步
- (void)mainSyncMethod;
//主队列异步
- (void)mainAsyncMethod;

//延迟执行
- (void)GCDAfterRunMethod;

//更改优先级
- (void)GCDSetTargetQueueMethod;

//自动执行任务组
- (void)GCDAutoDispatchGroupMethod;
//手动执行任务组
- (void)GCDManualDispatchGroupMethod;

//栅栏任务
- (void)GCDBarrierAsyncMethod;

//循环任务
- (void)GCDDispatchApplyMethod;

//队列挂起和唤醒
- (void)GCDDispatch_suspend_resume;

//队列信号量
- (void)GCDDispatchSemaphore;

@end
