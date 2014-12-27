//
//  GSSystem.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/26.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSSystem.h"

@implementation GSSystem
static GSSystem* systemService;
+ (GSSystem*)sharedSystem
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        systemService =[[self alloc] init];
        systemService.qiniuUploadToken = @"Q2fjtrE6q99QwF2h334He_Ne_0oPsmRpOeTx2b6S:E685-0uQhK0497IVZIEpnTRNJws=:eyJzY29wZSI6InRlc3RwZXRhbGsiLCJkZWFkbGluZSI6MTQxOTY0Mzg2Nn0=";
    });
    return systemService;
}
@end
