//
//  ViewController.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/27.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "ViewController.h"
#import "NSThreadViewController.h"
#import "NSOperationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nsThread:(id)sender {
    NSThreadViewController *controller = [[NSThreadViewController alloc] initWithStoryboard];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)gcd:(id)sender {
    
}

- (IBAction)nsOperation:(id)sender {
    NSOperationViewController *controller = [[NSOperationViewController alloc] initWithStoryboard];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
