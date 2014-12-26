//
//  GSDBManager.h
//  GirlsOrg
//
//  Created by Tolecen on 14/12/26.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSUserInfo.h"
@interface GSDBManager : NSObject
+(void)saveUserInfoWithUserInfo:(GSUserInfo *)info;
@end
