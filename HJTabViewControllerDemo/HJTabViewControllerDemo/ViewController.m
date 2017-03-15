//
//  ViewController.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/1/6.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "TestTabViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)onBtnClick:(id)sender {
    TestTabViewController *vc = [TestTabViewController new];
    
//    TestViewController *vc = [TestViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navVC animated:YES completion:nil];
}

@end
