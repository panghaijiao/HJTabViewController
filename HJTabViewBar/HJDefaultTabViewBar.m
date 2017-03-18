//
//  HJDefaultTabViewBar.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/16.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HJDefaultTabViewBar.h"

@interface HJDefaultTabViewBar () {
    UIView      *_indicatorView;
    UIView      *_seperatorView;
    NSInteger   _curIndex;
}

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSMutableDictionary *widths;

@end

@implementation HJDefaultTabViewBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.widths = [NSMutableDictionary dictionary];
        
        self.normalColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.highlightedColor = [UIColor colorWithRed:29.0f/255.0f green:154.0f/255.0f blue:255.0f/255.0f alpha:1];
        
        _indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
        _indicatorView.backgroundColor = self.highlightedColor;
        _indicatorView.layer.cornerRadius = 1;
        _indicatorView.layer.masksToBounds = YES;
        [self addSubview:_indicatorView];
        
        _seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 0.5, CGRectGetWidth(self.bounds), 0.5)];
        _seperatorView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        _seperatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_seperatorView];
        
        return self;
    }
    return nil;
}

#pragma mark -

- (void)tabScrollXPercent:(CGFloat)percent {
    percent = MAX(0, percent);
    percent = MIN(1, percent);
    [self updateIndicatorFrameWithPercent:percent];
}

- (void)tabDidScrollToIndex:(NSInteger)index {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.enabled = YES;
    }];
    _curIndex = index;
    UIButton *curBtn = [self buttonAtIndex:_curIndex];
    curBtn.enabled = NO;
    
    CGFloat percent = (CGFloat)index / MAX(1, self.buttons.count - 1);
    [self updateIndicatorFrameWithPercent:percent];
}

- (void)updateIndicatorFrameWithPercent:(CGFloat)percent {
    if (self.buttons == 0) {
        return;
    }
    NSInteger index = (NSInteger)((self.buttons.count - 1) * percent);
    
    CGFloat averageWidth = CGRectGetWidth(self.frame) / self.buttons.count;
    CGFloat preWidth = [self.widths[@(index)] floatValue];
    if (preWidth == 0) {
        preWidth = averageWidth;
    }
    
    if (index == self.buttons.count - 1) {
        CGRect rect = _indicatorView.frame;
        rect.size.width = preWidth;
        rect.origin.x = CGRectGetWidth(self.bounds) - averageWidth / 2.0f - preWidth / 2.0f;
        _indicatorView.frame = rect;
        return;
    }
    
    CGFloat nextWidth = [self.widths[@(index+1)] floatValue];
    if (nextWidth == 0) {
        nextWidth = averageWidth;
    }
    
    CGFloat prePercent = (CGFloat)index / MAX(1, self.buttons.count - 1);
    CGFloat nextPercent = (CGFloat)(index + 1) / MAX(1, self.buttons.count - 1);
    
    CGFloat width = preWidth + (percent - prePercent) / (nextPercent - prePercent) * (nextWidth - preWidth);
    CGFloat centerX = averageWidth * (0.5 + (self.buttons.count - 1) * percent);
    
    CGRect rect = _indicatorView.frame;
    rect.origin.x = centerX - width / 2.0f;
    rect.size.width = width;
    _indicatorView.frame = rect;
}

#pragma mark -
- (void)reloadTabIndex:(NSInteger)index {
    if (index >= self.buttons.count) {
        return;
    }
    
    UIButton *btn = [self.buttons objectAtIndex:index];
    id title = [self.delegate tabViewBar:self titleForIndex:index];
    
    if ([title isKindOfClass:[NSString class]]) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateDisabled];
    } else {
        NSMutableAttributedString *normalAttString = [[NSMutableAttributedString alloc] initWithAttributedString:title];
        NSRange range = NSMakeRange(0, normalAttString.string.length);
        [normalAttString addAttribute:NSForegroundColorAttributeName value:self.normalColor range:range];
        [btn setAttributedTitle:normalAttString forState:UIControlStateNormal];
        
        NSMutableAttributedString *highlightedAttString = [[NSMutableAttributedString alloc] initWithAttributedString:title];
        range = NSMakeRange(0, highlightedAttString.string.length);
        [highlightedAttString addAttribute:NSForegroundColorAttributeName value:self.highlightedColor range:range];
        [btn setAttributedTitle:highlightedAttString forState:UIControlStateDisabled];
    }
    
    NSInteger width = [btn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.frame.size.width)].width;
    [self.widths setObject:@(width) forKey:@(index)];
    
    CGFloat percent = (CGFloat)_curIndex / MAX(1.0, self.buttons.count - 1);
    [self updateIndicatorFrameWithPercent:percent];
}

- (void)reloadTabBar {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        [btn removeFromSuperview];
    }];
    NSInteger count = [self.delegate numberOfTabForTabViewBar:self];
    CGFloat cellWidth = CGRectGetWidth(self.bounds) / count;
    _indicatorView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 8, cellWidth, 2);
    NSMutableArray *newBtns = [NSMutableArray arrayWithCapacity:count];
    for (u_int8_t index = 0; index < count; index++) {
        UIButton *btn = [self createButton];
        btn.tag = index;
        id title = [self.delegate tabViewBar:self titleForIndex:index];
        
        if ([title isKindOfClass:[NSString class]]) {
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateDisabled];
        } else {
            NSMutableAttributedString *normalAttString = [[NSMutableAttributedString alloc] initWithAttributedString:title];
            NSRange range = NSMakeRange(0, normalAttString.string.length);
            [normalAttString addAttribute:NSForegroundColorAttributeName value:self.normalColor range:range];
            [btn setAttributedTitle:normalAttString forState:UIControlStateNormal];
            
            NSMutableAttributedString *highlightedAttString = [[NSMutableAttributedString alloc] initWithAttributedString:title];
            range = NSMakeRange(0, highlightedAttString.string.length);
            [highlightedAttString addAttribute:NSForegroundColorAttributeName value:self.highlightedColor range:range];
            [btn setAttributedTitle:highlightedAttString forState:UIControlStateDisabled];
        }
        btn.frame = CGRectMake(cellWidth * index, 0, cellWidth, CGRectGetHeight(self.bounds));
        [self addSubview:btn];
        [newBtns addObject:btn];
        
        NSInteger width = [btn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.frame.size.width)].width;
        [self.widths setObject:@(width) forKey:@(index)];
    }
    self.buttons = newBtns;
    if (self.buttons.count < 1) {
        return;
    }
    [self tabDidScrollToIndex:_curIndex];
}

- (UIButton *)createButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.highlightedColor forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (IBAction)onBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tabViewBar:didSelectIndex:)]) {
        [self.delegate tabViewBar:self didSelectIndex:sender.tag];
    }
}

- (UIButton *)buttonAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.buttons.count) {
        return nil;
    }
    return self.buttons[index];
}

@end
