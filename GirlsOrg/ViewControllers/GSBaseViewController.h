//
//  GSBaseViewController.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+GSTarBarController.h"
#import "GSTabBar.h"
@class GSTabBarController;
@interface GSBaseViewController : UIViewController

- (CGFloat)acceptNavigationHeight;
- (void)openCamera;

@end
