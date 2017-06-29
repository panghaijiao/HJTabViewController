//
//  HJTabViewControllerPlugin_HeaderScroll.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/15.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewController+Private.h"
#import "HJTabViewController+ViewController.h"

@interface HJTabViewControllerPlugin_HeaderScroll ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation HJTabViewControllerPlugin_HeaderScroll

- (void)removePlugin {
    [self removePanGestureForIndex:self.tabViewController.curIndex];
}

- (void)loadPlugin {
    [self addPanGestureForIndex:self.tabViewController.curIndex];
    self.index = self.tabViewController.curIndex;
}

- (void)scrollViewWillScrollFromIndex:(NSInteger)index {
    self.index = index;
}

- (void)scrollViewDidScrollToIndex:(NSInteger)index {
    if (self.index == index) {
        return;
    }
    [self removePanGestureForIndex:self.index];
    [self addPanGestureForIndex:index];
    self.index = index;
}

#pragma mark -

- (void)addPanGestureForIndex:(NSInteger)index {
    UIViewController *vc = [self.tabViewController viewControllerForIndex:index];
    UIScrollView *tabContentScrollView = vc.tabContentScrollView;
    if (tabContentScrollView) {
        [self.tabViewController.view addGestureRecognizer:tabContentScrollView.panGestureRecognizer];
    }
}

- (void)removePanGestureForIndex:(NSInteger)index {
    UIViewController *vc = [self.tabViewController viewControllerForIndex:index];
    UIScrollView *tabContentScrollView = vc.tabContentScrollView;
    if (tabContentScrollView) {
        [self.tabViewController.view removeGestureRecognizer:tabContentScrollView.panGestureRecognizer];
    }
}

@end
