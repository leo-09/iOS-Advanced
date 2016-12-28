//
//  NSThreadViewController.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/27.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation NSThreadViewController

- (instancetype) initWithStoryboard {
    return [[UIStoryboard storyboardWithName:@"nsthread" bundle:nil] instantiateViewControllerWithIdentifier:@"NSThreadViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)downloadBtn:(id)sender {
    [self categoryNSthreadMethod];
//    [self classNSthreadMethod1];
//    [self classNSthreadMethod2];
//    [self objectNSthreadMethod];
}

//通过NSObject的分类方法开辟线程
- (void) categoryNSthreadMethod {
    [self performSelectorInBackground:@selector(downloadImage) withObject:nil];
}

//通过NSThread类方法开辟线程
- (void) classNSthreadMethod1 {
    [NSThread detachNewThreadSelector:@selector(downloadImage) toTarget:self withObject:nil];
}
- (void) classNSthreadMethod2 {
    [NSThread detachNewThreadWithBlock:^{
        [self downloadImage];
    }];
}

//通过NSThread对象方法去下载图片
- (void) objectNSthreadMethod {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    [thread start];// 开启线程
    thread.name = @"download image thread";
}

#pragma 下载并更新图片

- (void) downloadImage {
    NSURL *url = [NSURL URLWithString:@"https://p1.bpimg.com/524586/475bc82ff016054ds.jpg"];
    
    // 线程延迟5s
    [NSThread sleepForTimeInterval:5.0];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSLog(@"%@", data);
    
    //在子线程中下载图片
    NSLog(@"downloadImage: %@", [NSThread currentThread]);
    
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:data waitUntilDone:YES];
}

- (void) updateImage:(NSData *) data {
    //在主线程中更新UI
    NSLog(@"updateImage: %@", [NSThread currentThread]);
    
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
}

@end
