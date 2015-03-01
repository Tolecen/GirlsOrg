//
//  GSImageEditorToolbar.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 3/1/15.
//  Copyright (c) 2015 uzero. All rights reserved.
//

#import "GSImageEditorToolbar.h"

@interface GSImageEditorToolbar()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation GSImageEditorToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(70, frame.size.height);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return self;
}

//- (void)willMoveToSuperview:(UIView *)newSuperview {
//    if (newSuperview == nil) {
//        return;
//    }
//    [super willMoveToSuperview:newSuperview];
//}

#pragma mark -- CollectionView

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor getRandomColor];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

@end
