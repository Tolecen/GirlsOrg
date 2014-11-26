//
//  GSTabBarView.h
//  GirlsOrg
//
//  Created by Endless小白 on 14/11/25.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTabBar.h"

@interface GSTabBarView : UIView

@property (nonatomic, strong) GSTabBar *tabBar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL isTabBarHidding;

@end
