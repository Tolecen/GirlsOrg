//
//  GSNetWorkManager.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/8.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSNetWorkManager.h"
#ifndef UseDevelopMode
#define BaseURL @"http://www.chongwushuo.com/cws-api/servlet?isEncrypt=0&isCompress=0"
#define BaseQiNiuDownloadURL @"http://petalk.qiniudn.com/"
#define QINIUDomain @"petalk"
#else
#define BaseURL @"http://182.92.163.115/cws-api/servlet?isEncrypt=0&isCompress=0"
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

+(void)requestNOEncryptWithParamaters:(NSDictionary *)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"foo": @"bar"};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [manager POST:BaseURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
