//
//  LockViewController.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/28.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "LockViewController.h"

@interface LockViewController () {
    NSInteger tickets;//总票数
    NSInteger count;//当前卖出去票数
}

@property (nonatomic, strong) NSThread *threadOne;
@property (nonatomic, strong) NSThread *threadTwo;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tickets = 100;
    count = 0;
    
    // 锁对象
    self.lock = [[NSLock alloc] init];
    
    self.threadOne = [[NSThread alloc] initWithTarget:self selector:@selector(sellAction) object:nil];
    self.threadOne.name = @"thread--1";
    [self.threadOne start];
    
    self.threadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(sellAction) object:nil];
    self.threadTwo.name = @"thread--2";
    [self.threadTwo start];
}

- (void) sellAction {
    while (true) {
        [self.lock lock];// 上锁
        
        if (tickets > 0) {
            [NSThread sleepForTimeInterval:0];
            count = 100 - tickets;
            NSLog(@"当前总票数是：%d；卖出：%d。线程名:%@", tickets, count, [NSThread currentThread]);
            tickets--;
        } else {
            break;
        }
        
        [self.lock unlock];// 解锁
    }
}

- (void) sellAction2 {
    while (true) {
        @synchronized (self) {
            if (tickets > 0) {
                [NSThread sleepForTimeInterval:0];
                count = 100 - tickets;
                NSLog(@"当前总票数是：%d；卖出：%d。线程名:%@", tickets, count,[NSThread currentThread]);
                tickets--;
            } else {
                break;
            }
        }
    }
}

@end
