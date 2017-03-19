//
//  HJTabViewBar.h
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/15.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat HJTabViewBarDefaultHeight = 44.0f;

@protocol HJTabViewBar

@required
- (void)reloadTabBar;  // Subclass must implement -reloadTabBar

@optional
- (void)tabScrollXPercent:(CGFloat)percent;
- (void)tabScrollXOffset:(CGFloat)contentOffsetX;
- (void)tabDidScrollToIndex:(NSInteger)index;

@end

//_______________________________________________________________________________________________________________

@interface HJTabViewBar : UIView <HJTabViewBar>

@end
