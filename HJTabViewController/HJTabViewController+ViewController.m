//
//  HJTabViewController+ViewController.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/14.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewController+ViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (tabViewController)
@dynamic tabViewController, tabContentScrollView;

- (HJTabViewController *)tabViewController {
    return objc_getAssociatedObject(self, @selector(tabViewController));
}

- (void)setTabViewController:(HJTabViewController *)tabViewController {
    objc_setAssociatedObject(self, @selector(tabViewController), tabViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (UIScrollView *)tabContentScrollView {
    UIScrollView *scrollView = objc_getAssociatedObject(self, @selector(tabContentScrollView));
    if (scrollView) {
        return scrollView;
    }
    if ([self.view isKindOfClass:[UIScrollView class]]) {
        [self setTabContentScrollView:(UIScrollView *)self.view];
    } else {
        for (UIScrollView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIScrollView class]] && CGSizeEqualToSize(subview.frame.size, self.view.frame.size)) {
                [self setTabContentScrollView:subview];
                break;
            }
        }
    }
    return objc_getAssociatedObject(self, @selector(tabContentScrollView));
}

- (void)setTabContentScrollView:(UIScrollView *)tabContentScrollView {
    objc_setAssociatedObject(self, @selector(tabContentScrollView), tabContentScrollView, OBJC_ASSOCIATION_ASSIGN);
}

@end
