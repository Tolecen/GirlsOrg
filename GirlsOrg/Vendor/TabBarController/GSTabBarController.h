//
//  GSTabBarController.h
//  GirlsOrg
//
//  Created by Endless小白 on 14/11/25.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTabBarView.h"

@interface GSTabBarController : UIViewController <GSTabDelegate ,GSTabBarDelegate, UINavigationControllerDelegate>

// View Controllers handled by the tab bar controller.
@property (nonatomic, strong) NSMutableArray *viewControllers;

// This is the minimum height to display the title.
@property (nonatomic, assign) CGFloat minimumHeightToDisplayTitle;

// Used to show / hide the tabs title.
@property (nonatomic, assign) BOOL tabTitleIsHidden;

// Tabs icon colors.
@property (nonatomic, strong) NSArray *iconColors;

// Tabs selected icon colors.
@property (nonatomic, strong) NSArray *selectedIconColors;

// Tabs selected colors.
@property (nonatomic, strong) NSArray *tabColors;

// Tabs selected colors.
@property (nonatomic, strong) NSArray *selectedTabColors;

// Tabs icon glossy show / hide
@property (nonatomic, assign) BOOL iconGlossyIsHidden;

// Tab stroke Color
@property (nonatomic, strong) UIColor *tabStrokeColor;

// Tab top embos Color
@property (nonatomic, strong) UIColor *tabEdgeColor;

// Tab background image
@property (nonatomic, strong) NSString *backgroundImageName;

// Tab selected background image
@property (nonatomic, strong) NSString *selectedBackgroundImageName;

// Tab text color
@property (nonatomic, strong)  UIColor *textColor;

// Tab selected text color
@property (nonatomic, strong)  UIColor *selectedTextColor;

// Initialization with a specific height.
- (id)initWithTabBarHeight:(NSUInteger)height;

@end
