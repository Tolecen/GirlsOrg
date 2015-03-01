//
//  UIColor+utility.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 12/1/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (utility)

#define RGBCOLOR(r,g,b,a) [UIColor colorWithRed:(r / 255.f) green:(g / 255.f) blue:(b / 255.f) alpha:a]

/**
 *  Create a color from a HEX string
 *
 *  @param hexString HEX string
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 *  Create a color from HEX
 *
 *  @param hex HEX value
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithHex:(unsigned int)hex;

/**
 *  Create a color from HEX with alpha
 *
 *  @param hex   HEX value
 *  @param alpha Alpha value
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithHex:(unsigned int)hex
                    alpha:(float)alpha;

/**
 *  Create a random color
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)getRandomColor;

/**
 *  Create a color from a given color with alpha
 *
 *  @param color UIColor value
 *  @param alpha Alpha value
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithColor:(UIColor *)color
                      alpha:(float)alpha;

@end
