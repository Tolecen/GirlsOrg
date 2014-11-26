//
//  GSArrayDataSource.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/22/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSArrayDataSource.h"

@interface GSArrayDataSource()

@property (nonatomic, copy, readwrite) NSString *cellReuseIdentifier;

@property (nonatomic, copy, readwrite) GSArrayDataSourceCellConfigurationBlock cellConfigurationBlock;

@end

@implementation GSArrayDataSource

- (id)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ Failed to call designated initializer. Invoke `initWithItems:cellReuseIdentifier:cellConfigurationBlock:` instead.", NSStringFromClass([self class])] userInfo:nil];
}

- (instancetype)initWithItems:(NSArray *)items cellReuseIdentifier:(NSString *)cellReuseIdentifier cellConfigurationBlock:(GSArrayDataSourceCellConfigurationBlock)cellConfigurationBlock {
    if (self = [super init]) {
        self.items = items;
        self.cellConfigurationBlock = cellConfigurationBlock;
        self.cellReuseIdentifier = cellReuseIdentifier;
    }
    return self;
}

- (BOOL)sectionEnabled {
    if (_sectionEnabled) {
        BOOL __block itemsContainsSection = YES;
        [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![obj isKindOfClass:NSArray.class]) {
                itemsContainsSection = NO;
                *stop = YES;
            }
        }];
        _sectionEnabled = itemsContainsSection;
    }
    return _sectionEnabled;
}

- (NSInteger)sectionCount {
    if (self.sectionEnabled) {
        return self.items.count;
    } else {
        return 1;
    }
}

- (NSArray *)itemsInSection:(NSInteger)section {
    if (self.sectionEnabled) {
        return self.items[section];
    } else {
        return self.items;
    }
}


@end
