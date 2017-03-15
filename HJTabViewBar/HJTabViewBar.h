//
//  HJTabViewBar.h
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/15.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HJTabViewBar;

@protocol HJTabViewBarDateSource <NSObject>

- (id)tabViewBar:(HJTabViewBar *)tabViewBar titleForIndex:(NSInteger)index;

@optional

- (NSInteger)numberOfTabForTabViewBar:(HJTabViewBar *)TTTabViewBar;

- (CGFloat)heightForTabViewBar:(HJTabViewBar *)TTTabViewBar;

- (void)tabViewBar:(HJTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index;

@end

@interface HJTabViewBar : UIView

@property (nonatomic, weak) id<HJTabViewBarDateSource> dataSource;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightedColor;

- (void)reloadTabBar;

- (void)tabScrollXPercent:(CGFloat)percent;
- (void)tabDidScrollToIndex:(NSInteger)index;

@end
