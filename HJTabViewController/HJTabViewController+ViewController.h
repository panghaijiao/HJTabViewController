//
//  HJTabViewController+ViewController.h
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/14.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewController.h"

@interface UIViewController (tabViewController)

@property (nonatomic, weak) HJTabViewController *tabViewController;

@property (nonatomic, weak) UIScrollView        *tabContentScrollView; // ScrollView of childViewController. You can implement as necessary.

@end
