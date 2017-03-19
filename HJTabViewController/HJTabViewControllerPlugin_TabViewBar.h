//
//  HJTabViewControllerPlugin_TabViewBar.h
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/15.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewControllerPlugin_Base.h"
#import "HJTabViewBar.h"

@protocol HJTabViewBarPluginDelagate <NSObject>

@optional

- (void)tabViewController:(HJTabViewController *)tabViewController tabViewBarDidLoad:(HJTabViewBar *)tabViewBar;

@end

//_______________________________________________________________________________________________________________

/*
 You can enable custome tabViewBar by this plugin. Default tabViewBar is nil
 */
@interface HJTabViewControllerPlugin_TabViewBar : HJTabViewControllerPlugin_Base

- (instancetype)initWithTabViewBar:(HJTabViewBar *)tabViewBar delegate:(id<HJTabViewBarPluginDelagate>)delegate;

@end
