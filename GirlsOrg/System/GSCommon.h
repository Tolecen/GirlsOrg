//
//  GSCommon.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#ifndef GirlsOrg_GSCommon_h
#define GirlsOrg_GSCommon_h

#define UseDevelopMode 0

#define Channel @"1001"

#define UserAgreementUrlStr @"http://3g.163.com"

#define CurrentVersion [[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey] substringToIndex:([[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey] length]-5)]
#define DeviceModel  [UIDevice currentDevice].model
#define SystemVersion [UIDevice currentDevice].systemVersion

#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#define Inch3_5 [UIScreen mainScreen].bounds.size.height<500?YES:NO

#define DefaultNaviHeight                   64.f
#define DefaultCameraToolbarHeight          65.f
#define DefaultNavigationBarButtonWidth     60.f
#define DefaultNavigationBarButtonHeight    44.f

#define Screen_Width    [UIScreen mainScreen].bounds.size.width
#define Screen_Height   [UIScreen mainScreen].bounds.size.height

#define SFHServiceName @"nvrenbangtolecendesigned"
#define SFHAccount @"theUsername"
#define SFHToken  @"theAuthToken"

#define StartTimer(ignored)     NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];

#define EndTimer(msg)           NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; NSLog(@"%@", [NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);

#endif
