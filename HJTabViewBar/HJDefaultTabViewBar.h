//
//  HJDefaultTabViewBar.h
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/16.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewBar.h"
@class HJDefaultTabViewBar;

@protocol HJDefaultTabViewBarDelegate <NSObject>

- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar;

- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index;

@optional

- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index;

@end

@interface HJDefaultTabViewBar : HJTabViewBar

@property (nonatomic, weak) id<HJDefaultTabViewBarDelegate> delegate;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightedColor;

@end
