//
//  GSSystem.h
//  GirlsOrg
//
//  Created by Tolecen on 14/12/26.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSSystem : NSObject
@property (nonatomic,strong)NSString * username;
@property (nonatomic,strong)NSString * userid;
@property (nonatomic,strong)NSString * token;

+ (GSSystem*)sharedSystem;
@end
