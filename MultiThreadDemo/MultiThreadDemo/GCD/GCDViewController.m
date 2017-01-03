//
//  GCDViewController.m
//  MultiThreadDemo
//
//  Created by liyy on 2017/1/3.
//  Copyright © 2017年 liyy. All rights reserved.
//

#import "GCDViewController.h"
#import "GCDMethod.h"

@interface GCDViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 异步下载
- (IBAction)downLoadAction:(id)sender {
    self.imageView.image = nil;
    
    // 获取全局队列
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 异步下载图片
        NSURL *url = [NSURL URLWithString:@"https://p1.bpimg.com/524586/475bc82ff016054ds.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });
}

// 串行队列同步
- (IBAction)serialQueueSyncMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] serialQueueSyncMethod];
}

// 串行队列异步
- (IBAction)serialQueueAsyncMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] serialQueueAsyncMethod];
}

// 并发队列异步
- (IBAction)concurrentQueueSyncMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] concurrentQueueSyncMethod];
}

// 并发队列异步
- (IBAction)concurrentQueueAsyncMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] concurrentQueueAsyncMethod];
}

// 全局队列同步
- (IBAction)globalSyncMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] globalSyncMethod];
}

// 全局队列异步
- (IBAction)globalAsyncMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] globalAsyncMethod];
}

// 主队列同步
- (IBAction)mainSyncMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] mainSyncMethod];
}

// 主队列异步
- (IBAction)mainAsyncMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] mainAsyncMethod];;
}

// 延迟执行
- (IBAction)gcdAfterRunMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] GCDAfterRunMethod];
}

// 修改优先级
- (IBAction)gcdSetTargetQueueMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] GCDSetTargetQueueMethod];
}

// 自动执行任务组
- (IBAction)gcdAutoDispatchGroupMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] GCDAutoDispatchGroupMethod];
}

// 手动执行任务组
- (IBAction)gcdManualDispatchGroupMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] GCDManualDispatchGroupMethod];
}

// 添加栅栏任务
- (IBAction)gcdBarrierAsyncMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] GCDBarrierAsyncMethod];
}

// Apply循环执行任务
- (IBAction)gcdDispatchApplyMethod:(id)sender {
    [[GCDMethod shareGCDMethodManager] GCDDispatchApplyMethod];
}

// 队列的挂起和唤醒
- (IBAction)gcdDispatch_suspend_resume:(id)sender {
    [[GCDMethod shareGCDMethodManager] GCDDispatch_suspend_resume];
}

// 信号量
- (IBAction)gcdDispatchSemaphore:(id)sender {
    [[GCDMethod shareGCDMethodManager] GCDDispatchSemaphore];
}

// 队列IO操作
- (IBAction)gcdDispatch_IO:(id)sender {
    
}

@end
