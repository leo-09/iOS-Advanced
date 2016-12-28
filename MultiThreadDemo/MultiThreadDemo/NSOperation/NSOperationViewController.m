//
//  NSOperationViewController.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/28.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "NSOperationViewController.h"
#import "OperationMethod.h"
#import "SerialOperation.h"
#import "ConcurrenOperation.h"
#import "ConcurrenOperation2.h"

@interface NSOperationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation NSOperationViewController

- (instancetype) initWithStoryboard {
    return [[UIStoryboard storyboardWithName:@"nsoperation" bundle:nil] instantiateViewControllerWithIdentifier:@"NSOperationViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)invocationOperation:(id)sender {
    [[OperationMethod shareOperationManager] invocationOperation];
}

- (IBAction)blockOperation:(id)sender {
    [[OperationMethod shareOperationManager] blockOperation];
}

- (IBAction)addExecutionBlock:(id)sender {
    [[OperationMethod shareOperationManager] blockOperaionAddTask];
}

- (IBAction)subClassOperation:(id)sender {
    [[OperationMethod shareOperationManager] subClassOperation];
}

- (IBAction)addOperationToQueue:(id)sender {
    [[OperationMethod shareOperationManager] addOperationToQueue];
}

- (IBAction)addOperationWithBlockToQueue:(id)sender {
    [[OperationMethod shareOperationManager] addOperaionWithBlockToQueue];
}

- (IBAction)operateDependency:(id)sender {
    [[OperationMethod shareOperationManager] operationDependency];
}

- (IBAction)aysncDownloadImage:(id)sender {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        //创建url
        NSURL *url=[NSURL URLWithString:@"https://p1.bpimg.com/524586/475bc82ff016054ds.jpg"];
        //将资源转换为二进制
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSLog(@"2--->%@",[NSThread currentThread]);
        //将二进制转化为tup
        UIImage *image=[UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
    
    [queue addOperation:op];
}

- (IBAction)operation:(id)sender {
    [self serialOperarion];
    [self concurrenOperation];
    [self concurrenOperation2];
}

- (void) serialOperarion {
    SerialOperation *op = [[SerialOperation alloc] init];
    [op start];
    
    op.comBlock = ^(NSData *data){
        UIImage *image = [UIImage imageWithData:data];
        self.imageView.image = image;
    };
}

- (void) concurrenOperation {
    ConcurrenOperation *op = [[ConcurrenOperation alloc] init];
    [op start];
    
    op.comBlock = ^(NSData *data){
        UIImage *image = [UIImage imageWithData:data];
        self.imageView.image = image;
    };
    
    
//    //子线程运行 NSURLConnection代理不走
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        NSLog(@"========current NSthread = %@",[NSThread currentThread]);
//        ConcurrenOperation *op = [[ConcurrenOperation alloc] init];
//        [op start];
//        
//        op.comBlock = ^(NSData *data){
//            UIImage *image = [UIImage imageWithData:data];
//            self.imageView.image = image;
//        };
//    });


}

- (void) concurrenOperation2 {
    ConcurrenOperation2 *op = [[ConcurrenOperation2 alloc] init];
    op.comBlock = ^(NSData *data) {
        UIImage *image = [UIImage imageWithData:data];
        self.imageView.image = image;
    };
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
}

@end
