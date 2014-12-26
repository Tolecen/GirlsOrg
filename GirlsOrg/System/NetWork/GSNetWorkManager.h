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
+(void)requestWithParamaters:(NSDictionary *)dict success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+(void)requestWithEncryptParamaters:(NSDictionary *)dict success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+(void)uploadImg:(UIImage *)theImg TheType:(NSString *)imgType progress:(NSProgress * __autoreleasing *)progress
         success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;
@end
