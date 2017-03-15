//
//  HJTabViewController+Private.h
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/14.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewController.h"

@interface HJTabViewController (Private)

@property (nonatomic, readonly) UIScrollView  *scrollView;
@property (nonatomic, readonly) NSArray       *viewControllers;
@property (nonatomic, strong)   UIView        *tabHeaderView;

@end
