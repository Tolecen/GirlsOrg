//
//  GSTabBarView.m
//  GirlsOrg
//
//  Created by Endless小白 on 14/11/25.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSTabBarView.h"

@implementation GSTabBarView

#pragma mark - Setters

- (void)setTabBar:(GSTabBar *)tabBar
{
    if (_tabBar != tabBar)
    {
        [_tabBar removeFromSuperview];
        _tabBar = tabBar;
        [self addSubview:tabBar];
    }
}

- (void)setContentView:(UIView *)contentView
{
    NSLog(@"setContentView");
    if (_contentView != contentView)
    {
        [_contentView removeFromSuperview];
        _contentView = contentView;
        _contentView.frame = CGRectZero;
        NSLog(@"setContentView contentView %@",NSStringFromCGRect(_contentView.frame));
        [self addSubview:_contentView];
        [self sendSubviewToBack:_contentView];
    }
}

#pragma mark - Layout & Drawing

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect tabBarRect = _tabBar.frame;
    tabBarRect.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(_tabBar.bounds);
    [_tabBar setFrame:tabBarRect];
    
    CGRect contentViewRect = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - ((!_isTabBarHidding) ? CGRectGetHeight(_tabBar.bounds) : 0));
    _contentView.frame = contentViewRect;
    NSLog(@"layoutSubviews contentwill %@",NSStringFromCGRect(_contentView.frame));
    [_contentView setNeedsLayout];
}

@end
