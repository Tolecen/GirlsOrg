//
//  GSProfileVC.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSProfileVC.h"
#import "GSDetailPageViewController.h"
#import "ELHeaderView.h"
@interface GSProfileVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * profileTableView;
@property (nonatomic, weak) ELHeaderView *headerView;
@end

@implementation GSProfileVC

- (NSString *)tabImageName {
    return @"home_tab_icon_3";
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = CommonLocalizedStrings(@"personalCenter_title");
//    [[self navigationController] setNavigationBarHidden:YES];
//    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//        //        [self.navigationController.navigationBar setBackgroundImage:newImage forBarMetrics:0];
//        NSArray *list=self.navigationController.navigationBar.subviews;
//        for (id obj in list) {
//            if ([obj isKindOfClass:[UIImageView class]]) {
//                UIImageView *imageView=(UIImageView *)obj;
//                imageView.hidden=YES;
//            }
//        }
//    }

//    self.navigationController.navigationBar.translucent = YES;
    self.profileTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
//    _profileTableView.backgroundView = nil;
    _profileTableView.scrollsToTop = YES;
//    _profileTableView.backgroundColor = [UIColor clearColor];
    _profileTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_profileTableView];
    _profileTableView.dataSource = self;
    _profileTableView.delegate = self;
    
    ELHeaderView *headerView = [[ELHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 220)backGroudImageURL:@"http://g.hiphotos.baidu.com/zhidao/pic/item/3ac79f3df8dcd100dcd191ae738b4710b8122feb.jpg" headerImageURL:@"http://www.qqw21.com/article/uploadpic/2012-9/2012911193026322.jpg" title:CommonLocalizedStrings(@"personalCenter_title") subTitle:@"Purchase what you want"];
    headerView.viewController = self;
    headerView.scrollView = self.profileTableView;
    [self.view addSubview:headerView];
    _headerView = headerView;
    
//    self.profileTableView.contentOffset = CGPointMake(0, -64);
//    self.profileTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"goodCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor getRandomColor];
    cell.textLabel.text = @"profile";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GSDetailPageViewController * detailV = [[GSDetailPageViewController alloc] init];
    [detailV setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailV animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (!firstIn) {
        return;
    }
    firstIn = NO;
    self.profileTableView.frame = self.view.bounds;

    
}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//        //        [self.navigationController.navigationBar setBackgroundImage:newImage forBarMetrics:0];
//        NSArray *list=self.navigationController.navigationBar.subviews;
//        for (id obj in list) {
//            if ([obj isKindOfClass:[UIImageView class]]) {
//                UIImageView *imageView=(UIImageView *)obj;
//                imageView.hidden=NO;
//            }
//        }
//    }
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//        //        [self.navigationController.navigationBar setBackgroundImage:newImage forBarMetrics:0];
//        NSArray *list=self.navigationController.navigationBar.subviews;
//        for (id obj in list) {
//            if ([obj isKindOfClass:[UIImageView class]]) {
//                UIImageView *imageView=(UIImageView *)obj;
//                imageView.hidden=YES;
//            }
//        }
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
