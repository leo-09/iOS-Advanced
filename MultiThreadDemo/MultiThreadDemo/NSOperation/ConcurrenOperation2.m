//
//  ConcurrenOperation.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/28.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "ConcurrenOperation2.h"

@interface ConcurrenOperation2()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *data;

@property (nonatomic, assign) CFRunLoopRef operationRunLoop;

@end

@implementation ConcurrenOperation2

@synthesize executing = _executing;
@synthesize  finished = _finished;

- (BOOL) isConcurrent {
    return YES;
}

- (void) start {
    if (self.isFinished) {
        [self finish];
    }
    
    [self willChangeValueForKey:@"isExcuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExcecuting"];
    
    NSURL *url = [NSURL URLWithString:@"http://p1.bpimg.com/524586/79a7a2915b550222.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSOperationQueue *currentQueue = [NSOperationQueue currentQueue];
    BOOL backgroundQueue = (currentQueue != nil && currentQueue != [NSOperationQueue mainQueue]);
    NSRunLoop *targetRunLoop = (backgroundQueue) ? [NSRunLoop currentRunLoop] : [NSRunLoop mainRunLoop];
    
    [self.connection scheduleInRunLoop:targetRunLoop forMode:NSRunLoopCommonModes];
    [self.connection start];
    
    if (backgroundQueue) {
        self.operationRunLoop = CFRunLoopGetCurrent();
        CFRunLoopRun();
    }
}

- (void) cancel {
    if (!_executing) {
        return;
    }
    
    [super cancel];
    [self finish];
}

- (void) finish {
    self.connection = nil;
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _executing = NO;
    _finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
    
    if (self.comBlock) {
        self.comBlock(_data);
    }
}

#pragma mark - NSURLConnection delegate
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.data = [NSMutableData data];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.operationRunLoop) {
        CFRunLoopStop(self.operationRunLoop);
    }
    
    if (self.isCancelled) {
        return;
    }
    
    [self finish];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self finish];
}

@end
