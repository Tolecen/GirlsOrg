//
//  UserEntity.h
//  GirlsOrg
//
//  Created by Tolecen on 14/12/26.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserEntity : NSManagedObject

@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * birthdate;
@property (nonatomic, retain) NSString * avatarUrl;
@property (nonatomic, retain) NSString * bgUrl;
@property (nonatomic, retain) NSString * desInfo;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * phoneNum;
@property (nonatomic, retain) NSString * lat;
@property (nonatomic, retain) NSString * lon;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * regPlatform;
@property (nonatomic, retain) NSString * regPlatNickname;
@property (nonatomic, retain) NSString * authToken;
@property (nonatomic, retain) NSString * countryName;
@property (nonatomic, retain) NSString * address;

@end
