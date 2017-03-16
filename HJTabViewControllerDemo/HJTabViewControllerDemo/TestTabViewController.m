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
#import "HJDefaultTabViewBar.h"

@interface TestTabViewController () <HJTabViewControllerDataSource, HJTabViewControllerDelagate, HJTabViewBarPluginDelagate, HJDefaultTabViewBarDelegate>

@end

@implementation TestTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"olinone";
    self.tabDataSource = self;
    self.tabDelegate = self;
    [self enablePlugin:[HJTabViewControllerPlugin_HeaderScroll new]];
    
    HJDefaultTabViewBar *tabViewBar = [HJDefaultTabViewBar new];
    tabViewBar.delegate = self;
    HJTabViewControllerPlugin_TabViewBar *tabViewBarPlugin = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBar:tabViewBar delegate:self];
    [self enablePlugin:tabViewBarPlugin];
}

#pragma mark -

- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}

- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    if (index == 0) {
        return @"虾米";
    }
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"网易云 5"];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(3, 2)];
    return attString;
}

- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    [self scrollToIndex:index animated:YES];
}

#pragma mark -

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY {
    self.navigationController.navigationBar.alpha = contentPercentY;
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
