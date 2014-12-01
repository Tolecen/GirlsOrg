//
//  FSIndicatorView.h
//  PeopleDaily2014
//
//  Created by Endless小白 on 14/12/1.
//  Copyright (c) 2014年 people. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kGSMenuIndicatorDefaultHeight   2.f

@interface GSIndicatorView : UIView

@property (nonatomic, assign) CGFloat indicatorWidth;

+ (instancetype)indicatorView;

@end
