//
//  ViewController.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/1/6.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "ViewController.h"
#import "TestTabViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)onBtnClick:(id)sender {
    TestTabViewController *vc = [TestTabViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navVC animated:YES completion:nil];
}

@end
