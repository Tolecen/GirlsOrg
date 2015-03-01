//
//  UIColor+utility.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 12/1/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "UIColor+utility.h"

@implementation UIColor (utility)

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *subString = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? subString : [NSString stringWithFormat:@"%@%@", subString, subString];
    unsigned hexComponent;
    //一个NSScanner对象解释并转换成一个字符NSString值的对象为数量和字符串。
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.f;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch (colorString.length) {
        case 3:
            //#RGB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:1];
            green = [self colorComponentFrom:colorString start:1 length:1];
            blue = [self colorComponentFrom:colorString start:2 length:1];
            break;
        case 4:
            //#ARGB
            alpha = [self colorComponentFrom:colorString start:0 length:1];
            red = [self colorComponentFrom:colorString start:1 length:1];
            green = [self colorComponentFrom:colorString start:2 length:1];
            blue = [self colorComponentFrom:colorString start:3 length:1];
            break;
        case 6:
            //#RRGGBB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:2];
            green = [self colorComponentFrom:colorString start:2 length:2];
            blue = [self colorComponentFrom:colorString start:4 length:2];
            break;
        case 8:
            //#AARRGGBB
            alpha = [self colorComponentFrom:colorString start:0 length:2];
            red = [self colorComponentFrom:colorString start:2 length:2];
            green = [self colorComponentFrom:colorString start:4 length:2];
            blue = [self colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            [NSException raise:@"Invalid color value" format:@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return RGBCOLOR(red, green, blue, alpha);
}

+ (UIColor *)colorWithHex:(unsigned int)hex alpha:(float)alpha {
    float red = (float)((hex & 0xFF0000) >> 16);
    float green = (float)((hex & 0xFF00) >> 8);
    float blue = (float)(hex & 0xFF);
    return RGBCOLOR(red, green, blue, alpha);
}

+ (UIColor *)colorWithHex:(unsigned int)hex {
    return [UIColor colorWithHex:hex alpha:1.f];
}

+ (UIColor *)getRandomColor {
    int red = arc4random() % 255;
    int green = arc4random() % 255;
    int blue = arc4random() % 255;
    return RGBCOLOR(red, green, blue, 1);
}

+ (UIColor *)colorWithColor:(UIColor *)color alpha:(float)alpha {
    if ([color isEqual:[UIColor whiteColor]]) {
        return [UIColor colorWithWhite:1.f alpha:alpha];
    }
    if ([color isEqual:[UIColor blackColor]]) {
        return [UIColor colorWithWhite:0.f alpha:alpha];
    }
    /* Return the color components (including alpha) associated with `color'. */
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:alpha];
}

@end
