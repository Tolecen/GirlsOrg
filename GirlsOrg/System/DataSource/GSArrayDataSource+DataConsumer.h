//
//  GSArrayDataSource+DataConsumer.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/22/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSArrayDataSource.h"
#import "GSDataProvider.h"

@interface GSArrayDataSource (DataConsumer) <GSDataConsumer>

@property (nonatomic, copy) void(^receivedItemsFormDataProviderBlock)(GSDataProvider *dataProvider, NSArray *items, NSError *error);

@end
