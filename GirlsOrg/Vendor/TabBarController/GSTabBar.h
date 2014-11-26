//
//  GSTabBar.h
//  GirlsOrg
//
//  Created by Endless小白 on 14/11/25.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTab.h"

@class GSTabBar;
@protocol GSTabBarDelegate <NSObject>
@required

// Used by the TabBarController to be notified when a tab is pressed
- (void)tabBar:(GSTabBar *)AKTabBarDelegate didSelectTabAtIndex:(NSInteger)index;

@end

@interface GSTabBar : UIView

@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, strong) GSTab *selectedTab;
@property (nonatomic, assign) id<GSTabBarDelegate> delegate;

// Tab top embos Color
@property (nonatomic, strong) UIColor *edgeColor;

// Tabs selected colors.
@property (nonatomic, strong) NSArray *tabColors;

// Tab background image
@property (nonatomic, strong) NSString *backgroundImageName;

- (void)tabSelected:(GSTab *)sender;


@end
