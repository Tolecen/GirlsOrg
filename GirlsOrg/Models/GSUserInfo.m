//
//  GSUserInfo.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/26.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSUserInfo.h"

@implementation GSUserInfo
- (id)initWithUserInfo:(NSDictionary*)info
{
    self = [super init];
    if (self) {
        self.userid = [self makeStrWithObj:info[@"id"]];
        self.username = [self makeStrWithObj:info[@"username"]];
//        self.password = [self makeStrWithObj:info[@"password"]];
        self.nickname = [self makeStrWithObj:info[@"nickname"]];
        self.desInfo = [self makeStrWithObj:info[@"description"]];
        self.gender = [self makeStrWithObj:info[@"gender"]];
        self.birthdate = [self makeStrWithObj:info[@"birthday"]];
        self.phoneNum = [self makeStrWithObj:info[@"phone"]];
        self.avatarUrl = [self makeStrWithObj:info[@"avatar"]];
        self.bgUrl = [self makeStrWithObj:info[@"background"]];
        self.lat = [self makeStrWithObj:info[@"lat"]];
        self.lon = [self makeStrWithObj:info[@"lon"]];
        self.area = [self makeStrWithObj:info[@"address"]];
        self.regPlatform = [self makeStrWithObj:info[@"from_where"]];
        self.regPlatNickname = [self makeStrWithObj:info[@"third_nick"]];
        self.authToken = [self makeStrWithObj:info[@"token"]];
    }
    return self;
}
-(NSString *)makeStrWithObj:(id)obj
{
    if (!obj) {
        return @"";
    }
    else
    {
        if ([obj isKindOfClass:[NSNull class]]) {
            return @"";
        }
        else if ([obj isEqualToString:@"<null>"]){
            return @"";
        }
        else
            return obj;
    }
}
@end
