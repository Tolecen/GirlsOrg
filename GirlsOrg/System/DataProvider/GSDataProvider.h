//
//  GSDataProvider.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/21/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GSDataProviderLoadingType) {
    GSDataProviderLoadingTypeReload    = 0,
    GSDataProviderLoadingTypeNew   = 1,
    GSDataProviderLoadingTypeMore  = 2
};

@class GSDataProvider;
@protocol GSDataConsumer <NSObject>

- (void)dataProvider:(GSDataProvider *)dataProvider didFinishLoadItems:(NSArray *)items loadingType:(GSDataProviderLoadingType)loadingType error:(NSError *)error;

@end

@interface GSDataProvider : NSObject

@property (nonatomic, weak) id<GSDataConsumer> dataConsumer;

+ (instancetype)dataProvider;

- (void)reload;

- (void)loadNew;

- (void)loadMore;

@end
