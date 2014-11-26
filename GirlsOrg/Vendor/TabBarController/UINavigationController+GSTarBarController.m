//
//  UINavigationController+GSTarBarController.m
//  GirlsOrg
//
//  Created by Endless小白 on 14/11/25.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "UINavigationController+GSTarBarController.h"

@implementation UINavigationController (GSTarBarController)

- (NSString *)tabImageName
{
    return [[self.viewControllers objectAtIndex:0] tabImageName];
}

- (NSString *)tabTitle
{
    return [[self.viewControllers objectAtIndex:0] tabTitle];
}

@end
