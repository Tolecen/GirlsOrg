//
//  GSAppDelegate.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/11/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign,nonatomic) SEL loginSel;
@property (strong,nonatomic) UIViewController *doLoginViewController;

+ (GSAppDelegate *)shareInstance;
- (void)login:(id)obj selector:(SEL)selector;

@end
