//
//  ViewController.m
//  MultiThreadDemo
//
//  Created by liyy on 2016/12/27.
//  Copyright © 2016年 liyy. All rights reserved.
//

#import "ViewController.h"
#import "NSThreadViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nsThread:(id)sender {
    NSThreadViewController *controller = [[NSThreadViewController alloc] initWithStoryboard];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)gcd:(id)sender {
    
}

- (IBAction)nsOperation:(id)sender {
    
}

@end
