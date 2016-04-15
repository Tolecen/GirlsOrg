//
//  GSBrowserTableviewHelper.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/7.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSBrowserTableviewHelper.h"
#import "GSDetailPageViewController.h"
#import "GSContentTableViewCell.h"
@implementation GSBrowserTableviewHelper
-(id)initWithController:(UIViewController *)thexController Tableview:(UITableView *)theTable
{
    if (self = [super init]) {
        self.theController = thexController;
        self.tableV = theTable;
        self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableV addHeaderWithTarget:self action:@selector(tableViewHeaderRereshing:)];
        //        [self.tableV headerBeginRefreshing];
        [self.tableV addFooterWithTarget:self action:@selector(tableViewFooterRereshing:)];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetWidth([UIScreen mainScreen].bounds)+65+50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"goodCell";
    GSContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (cell == nil) {
        cell = [[GSContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor getRandomColor];
//    cell.textLabel.text = [NSString stringWithFormat:@"TableView%d",self.tableViewType+1];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GSDetailPageViewController * detailV = [[GSDetailPageViewController alloc] init];
    [detailV setHidesBottomBarWhenPushed:YES];
    [self.theController.navigationController pushViewController:detailV animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (void)tableViewHeaderRereshing:(UITableView *)tableView
{
    [self performSelector:@selector(endHeaderRefreshing:) withObject:self.tableV afterDelay:2];
}
- (void)tableViewFooterRereshing:(UITableView *)tableView
{
    [self performSelector:@selector(endFooterRefreshing:) withObject:self.tableV afterDelay:2];
}
-(void)endHeaderRefreshing:(UITableView *)tableView
{
    [self.tableV headerEndRefreshing];
    [self.tableV reloadData];
}

-(void)endFooterRefreshing:(UITableView *)tableView
{
    [self.tableV footerEndRefreshing];
    [self.tableV reloadData];
    
}

@end
