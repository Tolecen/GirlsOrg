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
#import "SettingTableViewCell.h"
#import "GSSettingViewController.h"
#import "GSUserInfo.h"
#import "GSLogInViewController.h"
@interface GSProfileVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * profileTableView;
@property (nonatomic, weak) ELHeaderView *headerView;
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)NSArray * iconArray;
@end

@implementation GSProfileVC

- (NSString *)tabImageName {
    return @"home_tab_icon_3";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"我发布的",@"我的评论",@"我喜欢的",@"我的粉丝",@"我的关注",@"消息中心",@"设置"];
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
    self.profileTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    _profileTableView.backgroundView = nil;
    _profileTableView.scrollsToTop = YES;
    _profileTableView.backgroundColor = RGBCOLOR(250, 250, 250, 1);
    _profileTableView.showsVerticalScrollIndicator = NO;
    _profileTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_profileTableView];
    _profileTableView.dataSource = self;
    _profileTableView.delegate = self;
    
    ELHeaderView *headerView = [[ELHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 220)backGroudImageURL:@"http://m2.quanjing.com/2m/chineseview058/171-9835.jpg" headerImageURL:@"http://www.qqw21.com/article/uploadpic/2012-9/2012911193026322.jpg" title:CommonLocalizedStrings(@"personalCenter_title") subTitle:@"Purchase what you want"];
    headerView.viewController = self;
    headerView.scrollView = self.profileTableView;
    [self.view addSubview:headerView];
    _headerView = headerView;
    
//    self.profileTableView.contentOffset = CGPointMake(0, -64);
//    self.profileTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}
-(BOOL)loggedin
{
    if ([GSUserInfo isLogin]) {
        _profileTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else
        _profileTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return [GSUserInfo isLogin];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (![self loggedin]) {
        return 1;
    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self loggedin]) {
        static NSString *cellIdentifier = @"settingcell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        for (UIView * view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        UIView * bgv = [[UIView alloc] initWithFrame:CGRectMake(Screen_Width/2-60, 4, 120, 36)];
        bgv.backgroundColor = RGBCOLOR(250, 89, 172, 1);
        bgv.layer.cornerRadius = 18;
        bgv.layer.masksToBounds = YES;
        [cell.contentView addSubview:bgv];
        UILabel * tL = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2-60, 4, 120, 36)];
        tL.backgroundColor = [UIColor clearColor];
        tL.font = [UIFont systemFontOfSize:16];
        tL.textColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        tL.text = @"立刻登录";
        tL.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:tL];
//        cell.textLabel.textColor = RGBCOLOR(250, 89, 172, 1);
        return cell;

    }
    static NSString *cellIdentifier = @"settingcell";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (cell == nil) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        cell.titleL.text = self.titleArray[indexPath.row];
    }
    else if (indexPath.section==1) {
        cell.titleL.text = self.titleArray[indexPath.row+3];
    }
    else if (indexPath.section==2) {
        cell.titleL.text = self.titleArray[5];
    }
    else
        cell.titleL.text = self.titleArray[6];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (![self loggedin]) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        GSLogInViewController * loginV = [[GSLogInViewController alloc] init];
        UINavigationController * logNavi = [[UINavigationController alloc] initWithRootViewController:loginV];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:logNavi animated:YES completion:nil];
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==3) {
        GSSettingViewController * detailV = [[GSSettingViewController alloc] init];
        detailV.title = @"设置";
        [detailV setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:detailV animated:YES];
    }
    else{
        GSDetailPageViewController * detailV = [[GSDetailPageViewController alloc] init];
        [detailV setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:detailV animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![self loggedin]) {
        return 1;
    }
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        default:
            return 1;
            break;
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (!firstIn) {
        return;
    }
    firstIn = NO;
    self.profileTableView.frame = self.view.bounds;

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_profileTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if (![GSUserInfo isLogin]) {
//        GSLogInViewController * loginV = [[GSLogInViewController alloc] init];
//        UINavigationController * logNavi = [[UINavigationController alloc] initWithRootViewController:loginV];
//        [self presentViewController:logNavi animated:YES completion:nil];
//    }
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
