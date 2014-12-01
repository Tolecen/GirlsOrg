//
//  UIScrollView+visiableCenterScroll.h
//  GirlsOrg
//
//  Created by Endless小白 on 14/12/1.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (visiableCenterScroll)

- (void)scrollRectToVisibleCenteredOn:(CGRect)visibleRect
                             animated:(BOOL)animated;

@end
