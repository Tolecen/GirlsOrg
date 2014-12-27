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
#define BaseQiNiuDownloadURL @"http://onemin.qiniudn.com/"
#define QINIUDomain @"onemin"


#endif

NSString * gen_uuid()

{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    
    CFRelease(uuid_ref);
    
    NSString *uuid =  [[NSString  alloc]initWithCString:CFStringGetCStringPtr(uuid_string_ref, 0) encoding:NSUTF8StringEncoding];
    
    uuid = [uuid stringByReplacingOccurrencesOfString:@"-"withString:@""];
    
    CFRelease(uuid_string_ref);
    
    return uuid;
    
}
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

+(void)uploadImg:(UIImage *)theImg TheType:(NSString *)imgType progress:(NSProgress * __autoreleasing *)progress
success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure
{
    NSDateFormatter * dateF= [[NSDateFormatter alloc]init];
    dateF.dateFormat = @"yyyyMMdd";
    NSString *pathTime = [dateF stringFromDate:[NSDate date]];
    NSString * imgFileNameToUpload;
    if ([imgType isEqualToString:@"avatar"]) {
        imgFileNameToUpload = [NSString stringWithFormat:@"img/avatar/%@/%@.jpg",pathTime,gen_uuid()];
    }
    NSData *imageData  = nil;
    if (theImg) {
        imageData = UIImageJPEGRepresentation(theImg, 1);
    }
    NSLog(@"imgurl:%@",imgFileNameToUpload);
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:[GSSystem sharedSystem].qiniuUploadToken,@"token",imgFileNameToUpload,@"key", nil];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://upload.qiniu.com" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg"];

    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progressw = nil;
    NSLog(@"%@",progressw);
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progressw completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            failure(error);
        } else {
            NSLog(@"%@ =========%@", response, responseObject);
            success([NSString stringWithFormat:@"%@%@",BaseQiNiuDownloadURL,[responseObject objectForKey:@"key"]]);
        }
    }];
    
    [uploadTask resume];
}

+(void)getUploadToken
{
    NSMutableDictionary * dict = [GSNetWorkManager commonDict];
    [dict setObject:@"qiniu" forKey:@"service"];
    [dict setObject:@"get_token" forKey:@"method"];
    [dict setObject:QINIUDomain forKey:@"qiniu_bucket"];
    [GSNetWorkManager requestWithEncryptParamaters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [GSSystem sharedSystem].qiniuUploadToken = [[responseObject objectForKey:@"data"] objectForKey:@"qiniu_token"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
