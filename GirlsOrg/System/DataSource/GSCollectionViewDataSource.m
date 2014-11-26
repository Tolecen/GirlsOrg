//
//  GSCollectionViewDataSource.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/22/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSCollectionViewDataSource.h"

@implementation GSCollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    if (self.cellConfigurationBlock) {
        self.cellConfigurationBlock(cell, indexPath, self.items[indexPath.section][indexPath.row]);
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self itemsInSection:section].count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
