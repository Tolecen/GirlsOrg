//
//  GSTab.h
//  GirlsOrg
//
//  Created by Endless小白 on 14/11/25.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GSTab;
@protocol GSTabDelegate <NSObject>
@optional

- (void)tabDidRecognizerLongPress:(GSTab *)GSTab;

@end

@interface GSTab : UIButton

@property (nonatomic, assign) id<GSTabDelegate> delegate;

// Image used to draw the icon.
@property (nonatomic, strong) NSString *tabImageWithName;

// Tab background image
@property (nonatomic, strong) NSString *backgroundImageName;

// Tab selected background image
@property (nonatomic, strong) NSString *selectedBackgroundImageName;

// Tab text color
@property (nonatomic, strong) UIColor *textColor;

// Tab selected text color
@property (nonatomic, strong) UIColor *selectedTextColor;

// Tabs title.
@property (nonatomic, strong) NSString *tabTitle;

// Tabs icon colors.
@property (nonatomic, strong) NSArray *tabIconColors;

// Tabs selected icon colors.
@property (nonatomic, strong) NSArray *tabIconColorsSelected;

// Tabs selected colors.
@property (nonatomic, strong) NSArray *tabSelectedColors;

// Tabs icon glossy show / hide
@property (nonatomic, assign) BOOL glossyIsHidden;

// Tabs icon recognizer action
@property (nonatomic, assign) BOOL recognizerLongPress;

// Tab stroke Color
@property (nonatomic, strong) UIColor *strokeColor;

// Tab top embos Color
@property (nonatomic, strong) UIColor *edgeColor;

// Height of the tab bar.
@property (nonatomic, assign) CGFloat tabBarHeight;

// Minimum height that permits the display of the tab's title.
@property (nonatomic, assign) CGFloat minimumHeightToDisplayTitle;

// Used to show / hide title.
@property (nonatomic, assign) BOOL titleIsHidden;

@end
