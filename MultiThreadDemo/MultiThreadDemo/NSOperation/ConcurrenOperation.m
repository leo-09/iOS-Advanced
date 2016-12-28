//
//  ConcurrenOperation.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/28.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "ConcurrenOperation.h"

@interface ConcurrenOperation()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *data;

@end

@implementation ConcurrenOperation

@synthesize executing = _executing;
@synthesize  finished = _finished;

- (BOOL) isConcurrent {
    return YES;
}

- (void) start {
    [self willChangeValueForKey:@"isExcuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExcecuting"];
    
    NSURL *url = [NSURL URLWithString:@"http://p1.bpimg.com/524586/79a7a2915b550222.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (_connection == nil) {
        [self finish];
    }
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
    [self finish];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self finish];
}

@end
