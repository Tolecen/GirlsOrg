//
//  GSSearchVC.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSSearchVC.h"
#import "GSMenuScroll.h"
#import "UINavigationItem+CustomItem.h"
#import "GSInvitePeopleViewController.h"
@interface GSSearchVC ()<FSMenuScrollDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)GSMenuScroll * topMenu;
@property (nonatomic, strong) UIScrollView * backScrollV;
@property (nonatomic, strong) UITableView * topicTableview;
@property (nonatomic, strong) UITableView * activeUserTableview;
@property (nonatomic, strong) UITableView * tagTableview;
@end

@implementation GSSearchVC

- (NSString *)tabImageName {
    return @"home_tab_icon_2";
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"广场";
    UIView * bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame)-70, 44)];
    [bgv setBackgroundColor:[UIColor clearColor]];
    
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.view.frame)-70-10, 44)];
    search.searchBarStyle = UISearchBarStyleMinimal;
    search.placeholder = @"搜索标签、用户";
    
    search.showsScopeBar = YES;
    UITextField *searchField = [search valueForKey:@"_searchField"];
    searchField.textColor = [UIColor whiteColor];
    [searchField setValue:RGBCOLOR(230, 230, 230, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [bgv addSubview:search];
    [search setImage:[UIImage imageNamed:@"search_top_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [self.navigationItem setItemWithCustomView:bgv itemType:left];
    
    UIView * rightBtnBgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [rightBtnBgv setBackgroundColor:[UIColor clearColor]];
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 60, 44)];
    [rightBtn setTitle:@"邀请" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBCOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightBtnBgv addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(toInvitePeoplePage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setItemWithCustomView:rightBtnBgv itemType:right];

//    CustomBarItem *rightItem = [CustomBarItem itemWithTitle:@"邀请/t" textColor:RGBCOLOR(255, 255, 255, 1) fontSize:15 itemType:right];//从右到左  第一个按钮
//    //[rightItem1 setOffset:-20];//两个item都会移动
//    [rightItem addTarget:self selector:@selector(invite) event:(UIControlEventTouchUpInside)];
//    NSArray *barButtonItems = @[rightItem];
//    [self.navigationItem addCustomBarItems:barButtonItems itemType:right];
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_backScrollV];
    
     self.topMenu = [[GSMenuScroll alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 35)];
    _topMenu.delegate = self;
    [self.view addSubview:_topMenu];
    _topMenu.backgroundColor = RGBCOLOR(240, 240, 240, 0.93);
    
    NSMutableArray *menus = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        GSMenu *menu = [[GSMenu alloc] init];
        switch (i) {
            case 0:
                menu.title = @"话题";
                break;
            case 1:
                menu.title = @"达人";
                break;
            case 2:
                menu.title = @"标签";
                break;
//            case 3:
//                menu.title = @"标签";
//                break;
//            case 4:
//                menu.title = @"专题";
//                break;
            default:
                break;
        }
        [menus addObject:menu];
    }
    
    _topMenu.menus = menus.copy;
    [_topMenu reloadData];
    
    
    
    _backScrollV.delegate = self;
    _backScrollV.showsHorizontalScrollIndicator = NO;
    _backScrollV.showsVerticalScrollIndicator = NO;
    _backScrollV.backgroundColor = [UIColor clearColor];
    _backScrollV.pagingEnabled = YES;
    _backScrollV.bounces = NO;
    
    self.topicTableview = [[UITableView alloc]initWithFrame:CGRectZero];
    _topicTableview.backgroundView = nil;
    _topicTableview.scrollsToTop = YES;
    _topicTableview.backgroundColor = [UIColor clearColor];
    _topicTableview.showsVerticalScrollIndicator = NO;
    [_backScrollV addSubview:_topicTableview];
    _topicTableview.delegate = self;
    _topicTableview.dataSource = self;
    
    self.activeUserTableview = [[UITableView alloc]initWithFrame:CGRectZero];
    _activeUserTableview.backgroundView = nil;
    _activeUserTableview.scrollsToTop = YES;
    _activeUserTableview.backgroundColor = [UIColor clearColor];
    _activeUserTableview.showsVerticalScrollIndicator = NO;
    [_backScrollV addSubview:_activeUserTableview];
    _activeUserTableview.delegate = self;
    _activeUserTableview.dataSource = self;
    
    self.tagTableview = [[UITableView alloc]initWithFrame:CGRectZero];
    _tagTableview.backgroundView = nil;
    _tagTableview.scrollsToTop = YES;
    _tagTableview.backgroundColor = [UIColor clearColor];
    _tagTableview.showsVerticalScrollIndicator = NO;
    [_backScrollV addSubview:_tagTableview];
    _tagTableview.delegate = self;
    _tagTableview.dataSource = self;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.topMenu setFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 35)];
    self.backScrollV.frame = self.view.bounds;
    self.backScrollV.contentSize = CGSizeMake(3 * CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.topicTableview.frame = self.view.bounds;
    CGRect rect = self.view.bounds;
    rect.origin.x = CGRectGetWidth(self.view.frame);
    CGRect rect2 = rect;
    rect2.origin.x = CGRectGetWidth(self.view.frame)*2;
    self.activeUserTableview.frame = rect;
    self.tagTableview.frame = rect2;
    self.topicTableview.contentOffset = CGPointMake(0, -64-35);
    self.topicTableview.contentInset = UIEdgeInsetsMake(64+35, 0, 0, 0);
    self.activeUserTableview.contentOffset = CGPointMake(0, -64-35);
    self.activeUserTableview.contentInset = UIEdgeInsetsMake(64+35, 0, 0, 0);
    self.tagTableview.contentOffset = CGPointMake(0, -64-35);
    self.tagTableview.contentInset = UIEdgeInsetsMake(64+35, 0, 0, 0);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.topicTableview]) {
        return 80;
    }
    else if ([tableView isEqual:self.activeUserTableview]){
        return 80;
    }
    else
    {
        return 85;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.topicTableview]) {
        return 10;
    }
    else if ([tableView isEqual:self.activeUserTableview]){
        return 15;
    }
    else
        return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.topicTableview]) {
        static NSString *cellIdentifier = @"topicCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor redColor];
        cell.textLabel.text = @"tableview1";
        return cell;
        
    }
    else if ([tableView isEqual:self.activeUserTableview]){
        static NSString *cellIdentifier = @"userCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor redColor];
        cell.textLabel.text = @"tableview2";
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"tagCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"tableview3";
        return cell;
    }
}

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
}
-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
}
- (void)menuScrollDidSelected:(GSMenuScroll *)menuScroll menuIndex:(NSUInteger)selectIndex {
    
}
-(void)toInvitePeoplePage
{
    GSInvitePeopleViewController * inviteV = [[GSInvitePeopleViewController alloc] init];
    [inviteV setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:inviteV animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
