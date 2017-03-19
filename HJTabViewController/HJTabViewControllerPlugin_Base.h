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

/*
 Subclasses can implement as necessary. The default is a nop.
*/
@protocol HJTabViewControllerPlugin <NSObject>

- (void)scrollViewVerticalScroll:(CGFloat)contentPercentY;
- (void)scrollViewHorizontalScroll:(CGFloat)contentOffsetX;
- (void)scrollViewWillScrollFromIndex:(NSInteger)index;
- (void)scrollViewDidScrollToIndex:(NSInteger)index;

@end

//_______________________________________________________________________________________________________________

@interface HJTabViewControllerPlugin_Base : NSObject <HJTabViewControllerPlugin>

@property (nonatomic, assign) HJTabViewController  *tabViewController;

// Called only once when enable. Default does nothing
- (void)initPlugin;

// Called when tabViewController load. Default does nothing
- (void)loadPlugin;

// Called before tabViewController reload. Default does nothing
- (void)removePlugin;

@end
