//
//  GSNetWorkManager.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/8.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSNetWorkManager.h"
#ifndef UseDevelopMode
#define BaseURL @"http://app.zaofenxiang.com/api/base?isEncrypt=0"
#define BaseURLEncrypt @"http://app.zaofenxiang.com/api/base?isEncrypt=1"
#define BaseQiNiuDownloadURL @"http://petalk.qiniudn.com/"
#define QINIUDomain @"petalk"
#else
#define BaseURL @"http://app.zaofenxiang.com/api/base?isEncrypt=0"
#define BaseURLEncrypt @"http://app.zaofenxiang.com/api/base?isEncrypt=1"
#define BaseQiNiuDownloadURL @"http://testpetalk.qiniudn.com/"
#define QINIUDomain @"testpetalk"


#endif
@implementation GSNetWorkManager
+(NSMutableDictionary *)commonDict
{
    NSMutableDictionary * commonDict =[NSMutableDictionary dictionary];
    [commonDict setObject:@"10000000000" forKey:@"sim"];
    [commonDict setObject:Channel forKey:@"channel"];
    [commonDict setObject:CurrentVersion forKey:@"version"];
    [commonDict setObject:DeviceModel forKey:@"model"];
    [commonDict setObject:[@"iOS " stringByAppendingString:SystemVersion] forKey:@"platform"];
    [commonDict setObject:@"0.0.0.0" forKey:@"ipAddr"];
    [commonDict setObject:@"0:0:0:0" forKey:@"macAddr"];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0){
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        [commonDict setObject:idfa forKey:@"imei"];
        NSLog(@"IDFAAA:%@",idfa);
    }

    [commonDict setObject:@"00000000" forKey:@"imsi"];
    
    return commonDict;
}

+(void)requestWithParamaters:(NSDictionary *)dict success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.shouldEncryptWithAES = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    [manager POST:BaseURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([[responseObject objectForKey:@"error"] isEqualToString:@"200"]) {
            success(operation,responseObject);
        }
        else
        {
            NSError * error = [NSError errorWithDomain:[responseObject objectForKey:@"error"] code:[[responseObject objectForKey:@"error"] integerValue]  userInfo:nil];
            failure(operation,error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(operation,error);
    }];
}

+(void)requestWithEncryptParamaters:(NSDictionary *)dict success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.shouldEncryptWithAES = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    [manager POST:BaseURLEncrypt parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([[responseObject objectForKey:@"error"] isEqualToString:@"200"]) {
            success(operation,responseObject);
        }
        else
        {
            NSError * error = [NSError errorWithDomain:[responseObject objectForKey:@"error"] code:[[responseObject objectForKey:@"error"] integerValue]  userInfo:nil];
            failure(operation,error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(operation,error);
    }];
}

@end
