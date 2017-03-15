//
//  HJTabViewControllerPlugin_Base.h
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/14.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class  HJTabViewController;

@protocol HJTabViewControllerPlugin <NSObject>

- (void)scrollViewVerticalScroll:(CGFloat)contentPercentY;
- (void)scrollViewHorizontalScroll:(CGFloat)contentOffsetX;
- (void)scrollViewWillScrollFromIndex:(NSInteger)index;
- (void)scrollViewDidScrollToIndex:(NSInteger)index;

@end

//_______________________________________________________________________________________________________________

@interface HJTabViewControllerPlugin_Base : NSObject <HJTabViewControllerPlugin>

@property (nonatomic, assign) HJTabViewController  *tabViewController;

- (void)initPlugin;
- (void)loadPlugin;
- (void)removePlugin;

@end
