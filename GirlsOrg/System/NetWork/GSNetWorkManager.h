//
//  GSNetWorkManager.h
//  GirlsOrg
//
//  Created by Tolecen on 14/12/8.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AdSupport/AdSupport.h>
#import "AFNetworking.h"
#import "GSCommon.h"
@interface GSNetWorkManager : NSObject
+(NSMutableDictionary *)commonDict;
+(void)requestNOEncryptWithParamaters:(NSDictionary *)dict;
@end