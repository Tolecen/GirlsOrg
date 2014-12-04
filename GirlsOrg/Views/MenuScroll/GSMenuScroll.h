//
//  FSMenuScroll.h
//  PeopleDaily2014
//
//  Created by Endless小白 on 14/12/1.
//  Copyright (c) 2014年 people. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSMenu.h"
#import "GSIndicatorView.h"
@class GSMenuScroll;
@protocol FSMenuScrollDelegate <NSObject>

@required
- (void)menuScrollDidSelected:(GSMenuScroll *)menuScroll menuIndex:(NSUInteger)selectIndex;

@optional
- (void)menuScrollDidManagerSelected:(GSMenuScroll *)menuScroll;

@end

@interface GSMenuScroll : UIView

@property (nonatomic, weak) GSIndicatorView *indicatorView;

@property (nonatomic, weak) id<FSMenuScrollDelegate> delegate;

@property (nonatomic, assign) BOOL showLeftShadow;

@property (nonatomic, assign) BOOL showRightShadow;

@property (nonatomic, assign) BOOL showManagerButton;

@property (nonatomic, assign) BOOL shouldUniformizeMenus;

@property (nonatomic, copy) NSArray *menus;

@property (nonatomic, assign) NSInteger selectedItemIndex;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate;

- (CGRect)rectForSelectedItemAtIndex:(NSUInteger)index;

- (UIButton *)menuButtonAtIndex:(NSUInteger)index;

- (void)reloadData;

@end
