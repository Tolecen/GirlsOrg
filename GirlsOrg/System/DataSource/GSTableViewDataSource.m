//
//  GSTableViewDataSource.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/22/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSTableViewDataSource.h"

@implementation GSTableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier];
    if (self.cellConfigurationBlock) {
        self.cellConfigurationBlock(cell, indexPath, self.items[indexPath.section][indexPath.row]);
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self itemsInSection:section].count;
}

@end
