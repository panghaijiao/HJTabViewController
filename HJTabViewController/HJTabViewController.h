//
//  HJTabViewController.h
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/1/6.
//  Copyright © 2017年 olinone. All rights reserved.
//
//  -----------------------
//  |       _oo0oo_       |
//  |      o8888888o      |
//  |      (| █━█ |)      |
//  |       \  =  /       |
//  |        `---'        |
//  |~~~~~~~~~~~~~~~~~~~~~|
//  |  HeaderBottomInset  |
//  |~~~~~~~~~~~~~~~~~~~~~|
//  |                     |
//  |                     |
//  |                     |
//  -----------------------
//

#import <UIKit/UIKit.h>
@class HJTabViewController;
@class HJTabViewControllerPlugin_Base;
@protocol HJTabViewControllerDataSource;

@protocol HJTabViewControllerDelagate <NSObject>

@optional

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY;

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewHorizontalScroll:(CGFloat)contentOffsetX;

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewWillScrollFromIndex:(NSInteger)index;

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewDidScrollToIndex:(NSInteger)index;

@end

//_______________________________________________________________________________________________________________

@interface HJTabViewController : UIViewController

@property (nonatomic, weak)      id<HJTabViewControllerDataSource>  tabDataSource;
@property (nonatomic, weak)      id<HJTabViewControllerDelagate>    tabDelegate;

@property (nonatomic, assign)    BOOL            headerZoomIn; // Default is YES when headerView not nil

@property (nonatomic, readonly)  NSInteger       curIndex;

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

- (UIViewController *)viewControllerForIndex:(NSInteger)index;

- (void)reloadData;

/*
 Plugin
 */
- (void)enablePlugin:(HJTabViewControllerPlugin_Base *)plugin;

- (void)removePlugin:(HJTabViewControllerPlugin_Base *)plugin;

@end

//_______________________________________________________________________________________________________________

@protocol HJTabViewControllerDataSource <NSObject>

@required

- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController;

- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index;

@optional

- (UIView *)tabHeaderViewForTabViewController:(HJTabViewController *)tabViewController;

- (CGFloat)tabHeaderBottomInsetForTabViewController:(HJTabViewController *)tabViewController;

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController;

@end
