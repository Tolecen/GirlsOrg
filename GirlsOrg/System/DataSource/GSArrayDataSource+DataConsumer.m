//
//  GSArrayDataSource+DataConsumer.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/22/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSArrayDataSource+DataConsumer.h"
#import <objc/runtime.h>

NSString *const GSReceivedItemsFormDataProviderKey = @"GSReceivedItemsFormDataProviderKey";

@implementation GSArrayDataSource (DataConsumer)

- (void)setReceivedItemsFormDataProviderBlock:(void (^)(GSDataProvider *dataProvider, NSArray *items, NSError *error))receivedItemsFormDataProviderBlock {
    objc_setAssociatedObject(self, &GSReceivedItemsFormDataProviderKey, receivedItemsFormDataProviderBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(GSDataProvider *, NSArray *, NSError *))receivedItemsFormDataProviderBlock {
    return objc_getAssociatedObject(self, &GSReceivedItemsFormDataProviderKey);
}

- (void)dataProvider:(GSDataProvider *)dataProvider didFinishLoadItems:(NSArray *)items loadingType:(GSDataProviderLoadingType)loadingType error:(NSError *)error {
    if (!error) {
        switch (loadingType) {
            case GSDataProviderLoadingTypeReload:
                self.items = items;
                break;
            case GSDataProviderLoadingTypeNew:
                self.items = [[NSArray arrayWithArray:items] arrayByAddingObjectsFromArray:self.items];
                ;
                break;
            case GSDataProviderLoadingTypeMore:
                self.items = [[NSArray arrayWithArray:self.items] arrayByAddingObjectsFromArray:items];
                break;
            default:
                break;
        }
    }
    if (self.receivedItemsFormDataProviderBlock) {
        self.receivedItemsFormDataProviderBlock(dataProvider, items, error);
    }
}

@end
