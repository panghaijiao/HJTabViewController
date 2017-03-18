//
//  PageTabViewController.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/18.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "PageTabViewController.h"
#import "TableViewController.h"

@interface PageTabViewController () <HJTabViewControllerDataSource>

@end

@implementation PageTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabDataSource = self;
}

#pragma mark - HJTabViewControllerDataSource

- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return 2;
}

- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    TableViewController *vc = [TableViewController new];
    vc.index = index;
    return vc;
}

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame), 0, 0, 0);
}

@end
