//
//  GSTabBar.m
//  GirlsOrg
//
//  Created by Endless小白 on 14/11/25.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSTabBar.h"

static int kInterTabMargin = 0;

@implementation GSTabBar

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeRedraw;
        self.opaque = YES;
        self.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                 UIViewAutoresizingFlexibleHeight |
                                 UIViewAutoresizingFlexibleTopMargin);
    }
    return self;
}

#pragma mark - Setters and Getters

- (void)setTabs:(NSArray *)array
{
    if (_tabs != array) {
        for (GSTab *tab in _tabs) {
            [tab removeFromSuperview];
        }
        
        _tabs = array;
        
        for (GSTab *tab in _tabs) {
            tab.userInteractionEnabled = YES;
            [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    [self setNeedsLayout];
}

- (void)setSelectedTab:(GSTab *)selectedTab {
    if (selectedTab != _selectedTab) {
        [_selectedTab setSelected:NO];
        _selectedTab = selectedTab;
        [_selectedTab setSelected:YES];
    }
}

#pragma mark - Delegate notification

- (void)tabSelected:(GSTab *)sender
{
    [_delegate tabBar:self didSelectTabAtIndex:[_tabs indexOfObject:sender]];
}

#pragma mark - Drawing & Layout

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [RGBCOLOR(248, 41, 248, 1) set];
    CGContextFillRect(ctx, rect);
    for (GSTab *tab in _tabs)
        CGContextFillRect(ctx, CGRectMake(tab.frame.origin.x - kInterTabMargin, 0, kInterTabMargin, rect.size.height));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat screenWidth = self.bounds.size.width;
    CGFloat tabNumber = _tabs.count;
    CGFloat tabWidth = screenWidth / tabNumber;
    CGRect rect = self.bounds;
    rect.size.width = tabWidth;
    
    for (GSTab *tab in _tabs) {
        tab.frame = CGRectMake(rect.origin.x, rect.origin.y, tabWidth, rect.size.height);
        [self addSubview:tab];
        rect.origin.x = tab.frame.origin.x + tab.frame.size.width;
    }
}

@end
