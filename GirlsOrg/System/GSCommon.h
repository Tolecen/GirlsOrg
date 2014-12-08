//
//  GSCommon.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#ifndef GirlsOrg_GSCommon_h
#define GirlsOrg_GSCommon_h

#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBCOLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define StartTimer(ignored)     NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];

#define EndTimer(msg)           NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; NSLog(@"%@", [NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);

#define UseDevelopMode 0

#define Channel @"1001"

#define CurrentVersion [[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey] substringToIndex:([[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey] length]-5)]
#define DeviceModel  [UIDevice currentDevice].model
#define SystemVersion [UIDevice currentDevice].systemVersion

#endif
