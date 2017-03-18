//
//  HJTabViewControllerPlugin_TabViewBar.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/15.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJTabViewController+Private.h"
#import "HJTabViewBar.h"

@interface HJTabViewControllerPlugin_TabViewBar ()  {
    BOOL _loadFlag;
    NSInteger _tabCount;
    CGFloat _maxIndicatorX;
}

@property (nonatomic, weak) id<HJTabViewBarPluginDelagate> delegate;

@property (nonatomic, strong) HJTabViewBar *tabViewBar;

@end

@implementation HJTabViewControllerPlugin_TabViewBar

- (instancetype)initWithTabViewBar:(HJTabViewBar *)tabViewBar delegate:(id<HJTabViewBarPluginDelagate>)delegate; {
    if (self = [super init]) {
        self.tabViewBar = tabViewBar;
        self.delegate = delegate;
    }
    return self;
}

- (void)removePlugin {
    [self.tabViewBar removeFromSuperview];
    _loadFlag = NO;
}

- (void)initPlugin {
    if (CGRectGetHeight(self.tabViewBar.frame) == 0) {
        self.tabViewBar.frame = CGRectMake(0, 0, 0, HJTabViewBarDefaultHeight);
    }
}

- (void)loadPlugin {
    _tabCount = [self.tabViewController.tabDataSource numberOfViewControllerForTabViewController:self.tabViewController];
    _maxIndicatorX = CGRectGetWidth(self.tabViewController.scrollView.frame) * (_tabCount - 1);
    
    [self layoutTabViewBar];
    [self.tabViewBar reloadTabBar];

    if ([self.delegate respondsToSelector:@selector(tabViewController:tabViewBarDidLoad:)]) {
        [self.delegate tabViewController:self.tabViewController tabViewBarDidLoad:self.tabViewBar];
    }
}

- (void)layoutTabViewBar {
    if (_loadFlag) {
        return;
    }
    _loadFlag = YES;
    
    CGFloat tabBarHeight = CGRectGetHeight(self.tabViewBar.frame);
    if (!self.tabViewController.tabHeaderView) {
        self.tabViewBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.tabViewController.scrollView.frame), tabBarHeight);
        self.tabViewController.tabHeaderView = self.tabViewBar;
        return;
    }

    CGFloat tabBarFrameMinY = CGRectGetHeight(self.tabViewController.tabHeaderView.frame) - tabBarHeight;
    self.tabViewBar.frame = CGRectMake(0, tabBarFrameMinY, CGRectGetWidth(self.tabViewController.scrollView.frame), tabBarHeight);
    self.tabViewBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.tabViewController.tabHeaderView addSubview:self.tabViewBar];
}

#pragma mark -

- (void)scrollViewHorizontalScroll:(CGFloat)contentOffsetX {
    if ([self.tabViewBar respondsToSelector:@selector(tabScrollXOffset:)]) {
        [self.tabViewBar tabScrollXOffset:contentOffsetX];
    }
    CGFloat percent = contentOffsetX / _maxIndicatorX;
    if ([self.tabViewBar respondsToSelector:@selector(tabScrollXPercent:)]) {
        [self.tabViewBar tabScrollXPercent:percent];
    }
}

- (void)scrollViewDidScrollToIndex:(NSInteger)index {
    if ([self.tabViewBar respondsToSelector:@selector(tabDidScrollToIndex:)]) {
        [self.tabViewBar tabDidScrollToIndex:index];
    }
}

@end
