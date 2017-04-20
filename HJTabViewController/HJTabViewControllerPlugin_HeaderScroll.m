//
//  HJTabViewControllerPlugin_HeaderScroll.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/15.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewController+ViewController.h"

@implementation HJTabViewControllerPlugin_HeaderScroll

- (void)removePlugin {
    UIViewController *vc = [self.tabViewController viewControllerForIndex:self.tabViewController.curIndex];
    [self.tabViewController.view removeGestureRecognizer:vc.tabContentScrollView.panGestureRecognizer];
}

- (void)loadPlugin {
    UIViewController *vc = [self.tabViewController viewControllerForIndex:self.tabViewController.curIndex];
    UIScrollView *tabContentScrollView = vc.tabContentScrollView;
    if (tabContentScrollView) {
        [self.tabViewController.view addGestureRecognizer:tabContentScrollView.panGestureRecognizer];
    }
}

- (void)scrollViewWillScrollFromIndex:(NSInteger)index {
    UIViewController *vc = [self.tabViewController viewControllerForIndex:index];
    [self.tabViewController.view removeGestureRecognizer:vc.tabContentScrollView.panGestureRecognizer];
}

- (void)scrollViewDidScrollToIndex:(NSInteger)index {
    UIViewController *vc = [self.tabViewController viewControllerForIndex:index];
    UIScrollView *tabContentScrollView = vc.tabContentScrollView;
    if (tabContentScrollView) {
        [self.tabViewController.view addGestureRecognizer:tabContentScrollView.panGestureRecognizer];
    }
}

@end
