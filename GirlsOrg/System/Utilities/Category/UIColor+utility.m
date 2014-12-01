//
//  UIColor+utility.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 12/1/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "UIColor+utility.h"

@implementation UIColor (utility)

+ (UIColor *)getRandomColor {
    return [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
}

@end
