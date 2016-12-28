//
//  OperationMethod.h
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/28.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationMethod : NSObject

+ (instancetype) shareOperationManager;

#pragma mark NSoperation任务

// operation创建方式invocationOperation
- (void) invocationOperation;

// operation创建方式blockOperation
- (void) blockOperation;

// blockoperation添加任务
- (void) blockOperaionAddTask;

// 子类任务
- (void) subClassOperation;

#pragma mark 任务加入NSoperation队列
// 添加operationToQueue
- (void) addOperationToQueue;

- (void) addOperaionWithBlockToQueue;

//操作依赖
- (void) operationDependency;

@end
