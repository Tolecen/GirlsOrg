//
//  FSIndicatorView.m
//  PeopleDaily2014
//
//  Created by Endless小白 on 14/12/1.
//  Copyright (c) 2014年 people. All rights reserved.
//

#define kGSMenuIndicatorDefaultWidth    50.f

#import "GSIndicatorView.h"

@implementation GSIndicatorView

+ (instancetype)indicatorView {
    return [[GSIndicatorView alloc] initWithFrame:CGRectMake(0,
                                                             0,
                                                             kGSMenuIndicatorDefaultWidth,
                                                             kGSMenuIndicatorDefaultHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setIndicatorWidth:(CGFloat)indicatorWidth {
    _indicatorWidth = indicatorWidth;
    CGRect frame = self.frame;
    frame.size.width = indicatorWidth;
    self.frame = frame;
}

@end
