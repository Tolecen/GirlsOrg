//
//  GSDBManager.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/26.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSDBManager.h"
#import "UserEntity.h"
@implementation GSDBManager
+(void)saveUserInfoWithUserInfo:(GSUserInfo *)info
{
    NSPredicate * predicate = predicate = [NSPredicate predicateWithFormat:@"userid==[c]%@",info.userid];
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        UserEntity * userE = [UserEntity MR_findFirstWithPredicate:predicate];
        if (!userE) {
            userE = [UserEntity MR_createEntityInContext:localContext];
        }
        userE.userid = info.userid;
        userE.username = info.username;
        userE.password = @"";
        userE.gender = info.gender;
        userE.birthdate = info.birthdate;
        userE.avatarUrl = info.avatarUrl;
        userE.bgUrl = info.bgUrl;
        userE.desInfo = info.desInfo;
        userE.nickname = info.nickname;
        userE.phoneNum = info.phoneNum;
        userE.lat = info.lat;
        userE.lon = info.lon;
        userE.countryCode = @"";
        userE.area = info.area;
        userE.regPlatform = info.regPlatform;
        userE.regPlatNickname = info.regPlatNickname;
        userE.authToken = @"";
        userE.countryName = @"";
        userE.address = @"";

    }];
}
@end
