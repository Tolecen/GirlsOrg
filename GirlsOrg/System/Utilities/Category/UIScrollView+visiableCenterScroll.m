//
//  UIScrollView+visiableCenterScroll.m
//  GirlsOrg
//
//  Created by Endless小白 on 14/12/1.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "UIScrollView+visiableCenterScroll.h"

@implementation UIScrollView (visiableCenterScroll)

- (void)scrollRectToVisibleCenteredOn:(CGRect)visibleRect
                             animated:(BOOL)animated {
    CGRect centeredRect = CGRectMake(visibleRect.origin.x + visibleRect.size.width/2.0 - self.frame.size.width/2.0,
                                     visibleRect.origin.y + visibleRect.size.height/2.0 - self.frame.size.height/2.0,
                                     self.frame.size.width,
                                     self.frame.size.height);
    [self scrollRectToVisible:centeredRect
                     animated:animated];
}

@end
