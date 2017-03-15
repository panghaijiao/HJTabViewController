//
//  HJTabViewControllerPlugin_TabViewBar.h
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/15.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewControllerPlugin_Base.h"
#import "HJTabViewBar.h"

static const CGFloat HJTabViewBarDefaultHeight = 44.0f;

@interface HJTabViewControllerPlugin_TabViewBar : HJTabViewControllerPlugin_Base

- (instancetype)initWithTabViewBarDataSource:(id<HJTabViewBarDateSource>)dataSource;

@property (nonatomic, readonly) HJTabViewBar *tabViewBar;

@end
