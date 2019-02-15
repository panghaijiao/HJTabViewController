//
//  HJTabViewController+ViewController.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/14.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJTabViewController+ViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (HJTabViewController)
@dynamic hj_tabViewController, hj_tabContentScrollView;

- (HJTabViewController *)hj_tabViewController {
    return objc_getAssociatedObject(self, @selector(hj_tabViewController));
}

- (void)setHj_tabViewController:(HJTabViewController *)hj_tabViewController{
    objc_setAssociatedObject(self, @selector(hj_tabViewController), hj_tabViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (UIScrollView *)hj_tabContentScrollView {
    UIScrollView *scrollView = objc_getAssociatedObject(self, @selector(hj_tabContentScrollView));
    if (scrollView) {
        return scrollView;
    }
    if ([self.view isKindOfClass:[UIScrollView class]]) {
        [self setHj_tabContentScrollView:(UIScrollView *)self.view];
    } else {
        for (UIScrollView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIScrollView class]] && CGSizeEqualToSize(subview.frame.size, self.view.frame.size)) {
                [self setHj_tabContentScrollView:subview];
                break;
            }
        }
    }
    return objc_getAssociatedObject(self, @selector(hj_tabContentScrollView));
}

- (void)setHj_tabContentScrollView:(UIScrollView *)hj_tabContentScrollView{
    objc_setAssociatedObject(self, @selector(hj_tabContentScrollView), hj_tabContentScrollView, OBJC_ASSOCIATION_ASSIGN);
}

@end
