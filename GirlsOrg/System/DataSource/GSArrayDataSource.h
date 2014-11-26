//
//  GSArrayDataSource.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/22/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GSArrayDataSourceCellConfigurationBlock)(id cell, NSIndexPath *indexPath, id item);

@interface GSArrayDataSource : NSObject

@property (nonatomic, copy)     NSArray *items;

@property (nonatomic, assign)   BOOL sectionEnabled;

- (instancetype)initWithItems:(NSArray *)items
          cellReuseIdentifier:(NSString *)cellReuseIdentifier
       cellConfigurationBlock:(GSArrayDataSourceCellConfigurationBlock)cellConfigurationBlock;

@end

@interface GSArrayDataSource (Infomations)

@property (nonatomic, copy, readonly) NSString *cellReuseIdentifier;

@property (nonatomic, copy, readonly) GSArrayDataSourceCellConfigurationBlock cellConfigurationBlock;

@property (nonatomic, assign, readonly) NSInteger sectionCount;

- (NSArray *)itemsInSection:(NSInteger)section;

@end