//
//  TestTabViewController.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/15.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "TestTabViewController.h"
#import "TestViewController.h"
#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"

@interface TestTabViewController () <HJTabViewControllerDataSource, HJTabViewBarDateSource>

@end

@implementation TestTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
//    self.navigationController.navigationBarHidden = YES;
    self.tabDataSource = self;
    [self enablePlugin:[HJTabViewControllerPlugin_HeaderScroll new]];
    HJTabViewControllerPlugin_TabViewBar *tabViewBar = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBarDataSource:self];
    [self enablePlugin:tabViewBar];
}

- (id)tabViewBar:(HJTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    return @"列表";
}

- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return 2;
}

- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    TestViewController *vc = [TestViewController new];
    vc.index = index;
    return vc;
}

- (UIView *)tabHeaderViewForTabViewController:(HJTabViewController *)tabViewController {
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    headerView.image = [UIImage imageNamed:@"1"];
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    headerView.userInteractionEnabled = YES;
    return headerView;
}

- (CGFloat)tabHeaderBottomInsetForTabViewController:(HJTabViewController *)tabViewController {
    return HJTabViewBarDefaultHeight + CGRectGetMaxY(self.navigationController.navigationBar.frame);
}

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
