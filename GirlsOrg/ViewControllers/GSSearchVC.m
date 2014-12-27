//
//  GSSearchVC.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#define TopicReuseIdentifier    @"TopicReuseIdentifier"
#define ActiveReuseIdentifier   @"ActiveReuseIdentifier"
#define TagReuseIdentifier      @"TagReuseIdentifier"

#import "GSSearchVC.h"
#import "GSMenuScroll.h"
#import "UINavigationItem+CustomItem.h"
#import "GSInvitePeopleViewController.h"
#import "GSTopicTableViewCell.h"
#import "GSHotUserTableViewCell.h"

@interface GSSearchVC ()<FSMenuScrollDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

@property (nonatomic, strong) GSMenuScroll * topMenu;
@property (nonatomic, weak) UIScrollView * backScrollV;
@property (nonatomic, weak) UITableView * topicTableview;
@property (nonatomic, weak) UITableView * activeUserTableview;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong)UIButton * rightBtn;
@property (nonatomic, assign) BOOL topMenuTouched;
@property (nonatomic,strong)UIView * searchBgV;
@property (nonatomic,strong)UIView * searchMaskV;
@property (nonatomic,strong)UISearchBar * search;
@end

@implementation GSSearchVC

#pragma mark --Private

- (UITableView *)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    tableView.backgroundView = nil;
//    tableView.scrollsToTop = YES;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    return tableView;
}

- (UICollectionView *)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0.f;
    layout.minimumLineSpacing = 0.f;
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20) / 3, 50);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundView = nil;
//    collectionView.scrollsToTop = YES;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    return collectionView;
}

#pragma mark -- Life Cycle

- (NSString *)tabImageName {
    return @"home_tab_icon_2";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    firstIn = YES;
    self.topMenuTouched = NO;
    UIView * bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame)-70, 44)];
    [bgv setBackgroundColor:[UIColor clearColor]];
    
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.view.frame)-70-10, 44)];
    _search.searchBarStyle = UISearchBarStyleMinimal;
    _search.delegate = self;
    _search.placeholder = CommonLocalizedStrings(@"squareSearchBarPlaceHolder");
    
    _search.showsScopeBar = YES;
    UITextField *searchField = [_search valueForKey:@"_searchField"];
    searchField.textColor = [UIColor whiteColor];
    [searchField setValue:RGBCOLOR(230, 230, 230, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [bgv addSubview:_search];
    [_search setImage:[UIImage imageNamed:@"search_top_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [self.navigationItem setItemWithCustomView:bgv itemType:left];
    
    UIView * rightBtnBgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [rightBtnBgv setBackgroundColor:[UIColor clearColor]];
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setFrame:CGRectMake(0, 0, 60, 44)];
    [_rightBtn setTitle:CommonLocalizedStrings(@"square_topRightTitle1") forState:UIControlStateNormal];
    [_rightBtn setTitleColor:RGBCOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightBtnBgv addSubview:_rightBtn];
    _rightBtn.tag = 1;
    [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setItemWithCustomView:rightBtnBgv itemType:right];
    
    UIScrollView *backScrollV = [[UIScrollView alloc] initWithFrame:CGRectZero];
    backScrollV.delegate = self;
    backScrollV.showsHorizontalScrollIndicator = NO;
    backScrollV.showsVerticalScrollIndicator = NO;
    backScrollV.backgroundColor = [UIColor clearColor];
    backScrollV.pagingEnabled = YES;
    backScrollV.bounces = NO;
    [self.view addSubview:backScrollV];
    self.backScrollV = backScrollV;
    self.backScrollV.scrollsToTop = NO;
    
    self.topMenu = [[GSMenuScroll alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 35)];
    _topMenu.delegate = self;
    
    [self.view addSubview:_topMenu];
    _topMenu.backgroundColor = RGBCOLOR(240, 240, 240, 0.93);
    
    NSMutableArray *menus = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        GSMenu *menu = [[GSMenu alloc] init];
        switch (i) {
            case 0:
                menu.title = CommonLocalizedStrings(@"square_menuTitle1");
                break;
            case 1:
                menu.title = CommonLocalizedStrings(@"square_menuTitle2");
                break;
            case 2:
                menu.title = CommonLocalizedStrings(@"square_menuTitle3");
                break;
            default:
                break;
        }
        [menus addObject:menu];
    }
    
    _topMenu.menus = menus.copy;
    [_topMenu reloadData];
    self.topMenu.scrollView.scrollsToTop = NO;
    
    UITableView *topicTableView = [self createTableView];
//    [topicTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TopicReuseIdentifier];
    [self.backScrollV addSubview:topicTableView];
    self.topicTableview = topicTableView;
    self.topicTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.topicTableview.scrollsToTop = YES;
    
    UITableView *activeUserTableview = [self createTableView];
//    [activeUserTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:ActiveReuseIdentifier];
    [self.backScrollV addSubview:activeUserTableview];
    self.activeUserTableview = activeUserTableview;
    self.activeUserTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.activeUserTableview.scrollsToTop = NO;
    
    UICollectionView *collectionView = [self createCollectionView];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:TagReuseIdentifier];
    [self.backScrollV addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.scrollsToTop = NO;
    
    self.topicTableview.contentOffset = CGPointMake(0, -64-35);
    self.topicTableview.contentInset = UIEdgeInsetsMake(64+35, 0, 0, 0);
    self.activeUserTableview.contentOffset = CGPointMake(0, -64-35);
    self.activeUserTableview.contentInset = UIEdgeInsetsMake(64+35, 0, 0, 0);
    self.collectionView.contentOffset = CGPointMake(0, -64-35);
    self.collectionView.contentInset = UIEdgeInsetsMake(64+35, 0, 0, 0);
    
    [self addBackNavi];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (!firstIn) {
        return;
    }
    firstIn = NO;
    NSLog(@"viewDidLayoutSubviews view %@",NSStringFromCGRect(self.view.frame));
    [self.topMenu setFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 35)];
    self.backScrollV.frame = self.view.bounds;
    self.backScrollV.contentSize = CGSizeMake(3 * CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.topicTableview.frame = self.view.bounds;
    CGRect rect = self.view.bounds;
    rect.origin.x = CGRectGetWidth(self.view.frame);
    CGRect rect2 = rect;
    rect2.size.width = CGRectGetWidth(self.view.frame) - 20;
    rect2.origin.x = CGRectGetWidth(self.view.frame)*2 + 10;
    self.activeUserTableview.frame = rect;
    self.collectionView.frame = rect2;
 
}

#pragma mark -- UICollectionView

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TagReuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor getRandomColor];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

#pragma mark -- UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.topicTableview]) {
        return 10;
    } else {
        return 15;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.topicTableview]) {
//        return 50;
        float imW = (CGRectGetWidth([UIScreen mainScreen].bounds)-50)/4;
        return 60+imW+20;
    } else {
        float imW = (CGRectGetWidth([UIScreen mainScreen].bounds)-50)/4;
        return 60+imW+20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.topicTableview]) {
        static NSString *cellIdentifier = @"topicCell";
        GSTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        cell.backgroundColor = [UIColor getRandomColor];
//        cell.textLabel.text = @"tableview1";
        if (cell == nil) {
            cell = [[GSTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    } else {
        static NSString *cellIdentifier = @"hotUserCell";
        GSHotUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        //        cell.backgroundColor = [UIColor getRandomColor];
        //        cell.textLabel.text = @"tableview1";
        if (cell == nil) {
            cell = [[GSHotUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }
}
-(void)addSearchView
{
    self.searchBgV = [[UIView alloc] initWithFrame:CGRectMake(0, DefaultNaviHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-DefaultNaviHeight)];
    [self.view addSubview:self.searchBgV];
    self.searchBgV.backgroundColor = [UIColor clearColor];
    self.searchMaskV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-DefaultNaviHeight)];
    self.searchMaskV.backgroundColor = [UIColor blackColor];
    self.searchMaskV.alpha = 0.8;
    [self.searchBgV addSubview:self.searchMaskV];
}
-(void)removeSearchView
{
    [self.searchBgV removeFromSuperview];
    self.searchBgV = nil;
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self addSearchView];
    [self.rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.rightBtn.tag = 2;
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self.rightBtn setTitle:CommonLocalizedStrings(@"square_topRightTitle1") forState:UIControlStateNormal];
    self.rightBtn.tag = 1;
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
}
-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (self.view.frame.size.width==0) {
//        return;
//    }
    if (scrollView == _backScrollV) {
        if (!self.topMenuTouched) {
            NSLog(@"width:%f",self.view.frame.size.width);
            self.topMenu.indicatorView.frame = CGRectMake((self.view.frame.size.width/3*_backScrollV.contentOffset.x)/self.view.frame.size.width, self.topMenu.indicatorView.frame.origin.y, self.topMenu.indicatorView.frame.size.width, self.topMenu.indicatorView.frame.size.height);
        }            

        if (_backScrollV.contentOffset.x==0) {
            [self.topMenu setSelectedIndex:0 animated:NO calledDelegate:NO];
            self.topMenuTouched = NO;
            self.topicTableview.scrollsToTop = YES;
            self.activeUserTableview.scrollsToTop = NO;
            self.collectionView.scrollsToTop = NO;
        }
        else if(_backScrollV.contentOffset.x==self.view.frame.size.width){
            [self.topMenu setSelectedIndex:1 animated:NO calledDelegate:NO];
            self.topMenuTouched = NO;
            self.topicTableview.scrollsToTop = NO;
            self.activeUserTableview.scrollsToTop = YES;
            self.collectionView.scrollsToTop = NO;
        }
        else if(_backScrollV.contentOffset.x==self.view.frame.size.width*2){
            [self.topMenu setSelectedIndex:2 animated:NO calledDelegate:NO];
            self.topMenuTouched = NO;
            self.topicTableview.scrollsToTop = NO;
            self.activeUserTableview.scrollsToTop = NO;
            self.collectionView.scrollsToTop = YES;
        }
    }
}

- (void)menuScrollDidSelected:(GSMenuScroll *)menuScroll menuIndex:(NSUInteger)selectIndex {
    if (selectIndex==0) {
        self.topMenuTouched = YES;
        [_backScrollV setContentOffset:CGPointMake(0, 0) animated:YES];
        self.topicTableview.scrollsToTop = YES;
        self.activeUserTableview.scrollsToTop = NO;
        self.collectionView.scrollsToTop = NO;
    }
    else if(selectIndex==1)
    {
        self.topMenuTouched = YES;
        [_backScrollV setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
        self.topicTableview.scrollsToTop = NO;
        self.activeUserTableview.scrollsToTop = YES;
        self.collectionView.scrollsToTop = NO;
    }
    else
    {
        self.topMenuTouched = YES;
        [_backScrollV setContentOffset:CGPointMake(self.view.frame.size.width*2, 0) animated:YES];
        self.topicTableview.scrollsToTop = NO;
        self.activeUserTableview.scrollsToTop = NO;
        self.collectionView.scrollsToTop = YES;
    }
}
-(void)rightBtnClicked
{
    if (self.rightBtn.tag==1) {
        [self toInvitePeoplePage];
    }
    else
    {
        [self cancelSearchPage];
    }
}
-(void)cancelSearchPage
{
    [self.search resignFirstResponder];
    [self removeSearchView];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * theTouch = [touches anyObject];
    if ([[theTouch view] isEqual:self.searchMaskV]) {
        [self cancelSearchPage];
    }
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
