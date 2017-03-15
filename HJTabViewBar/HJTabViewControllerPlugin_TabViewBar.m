//
//  HJTabViewControllerPlugin_TabViewBar.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/15.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJTabViewController+Private.h"

@interface HJTabViewControllerPlugin_TabViewBar () <HJTabViewBarDateSource> {
    NSInteger _tabCount;
    CGFloat _tabbarHeight;
    CGFloat _maxIndicatorX;
}

@property (nonatomic, weak) id<HJTabViewBarDateSource> dataSource;

@property (nonatomic, strong) HJTabViewBar *tabViewBar;

@end

@implementation HJTabViewControllerPlugin_TabViewBar

- (instancetype)initWithTabViewBarDataSource:(id<HJTabViewBarDateSource>)dataSource {
    if (self = [super init]) {
        self.dataSource = dataSource;
    }
    return self;
}

- (void)removePlugin {
    self.tabViewBar.dataSource = nil;
    [self.tabViewBar removeFromSuperview];
    self.tabViewBar = nil;
}

- (void)initPlugin {
    if ([self.dataSource respondsToSelector:@selector(numberOfTabForTabViewBar:)]) {
        _tabCount = [self.dataSource numberOfTabForTabViewBar:self.tabViewBar];
    } else {
        _tabCount = [self.tabViewController.tabDataSource numberOfViewControllerForTabViewController:self.tabViewController];
    }
    if (_tabCount < 1) {
        return;
    }
    _maxIndicatorX = CGRectGetWidth(self.tabViewController.scrollView.frame) * (_tabCount - 1);

    _tabbarHeight = HJTabViewBarDefaultHeight;
    if ([self.dataSource respondsToSelector:@selector(heightForTabViewBar:)]) {
        _tabbarHeight = [self.dataSource heightForTabViewBar:self.tabViewBar];
    }
}

- (void)loadPlugin {
    if (!self.tabViewBar) {
        self.tabViewBar = [HJTabViewBar new];
        self.tabViewBar.dataSource = self;
        
        if (!self.tabViewController.tabHeaderView) {
            self.tabViewBar.frame = CGRectMake(0, 0, 0, _tabbarHeight);
            self.tabViewController.tabHeaderView = self.tabViewBar;
            return;
        }
        
        CGFloat tabBarFrameMinY = CGRectGetHeight(self.tabViewController.tabHeaderView.frame) - _tabbarHeight;
        self.tabViewBar.frame = CGRectMake(0, tabBarFrameMinY, CGRectGetWidth(self.tabViewController.scrollView.frame), _tabbarHeight);
        self.tabViewBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self.tabViewController.tabHeaderView addSubview:self.tabViewBar];
    }
    [self.tabViewBar reloadTabBar];
}

#pragma mark - 

- (id)tabViewBar:(HJTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    return [self.dataSource tabViewBar:tabViewBar titleForIndex:index];
}

- (NSInteger)numberOfTabForTabViewBar:(HJTabViewBar *)TTTabViewBar {
    return _tabCount;
}

- (CGFloat)heightForTabViewBar:(HJTabViewBar *)TTTabViewBar {
    return _tabbarHeight;
}

- (void)tabViewBar:(HJTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    [self.tabViewController scrollToIndex:index animated:YES];
}

- (void)scrollViewHorizontalScroll:(CGFloat)contentOffsetX {
    CGFloat percent = contentOffsetX / _maxIndicatorX;
    [self.tabViewBar tabScrollXPercent:percent];
}

- (void)scrollViewDidScrollToIndex:(NSInteger)index {
    [self.tabViewBar tabDidScrollToIndex:index];
}

@end
