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

    });
    return systemService;
}
@end
