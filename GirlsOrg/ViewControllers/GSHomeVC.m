//
//  GSHomeVC.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSHomeVC.h"
#import "GSMenuScroll.h"
#import "UINavigationItem+CustomItem.h"
@interface GSHomeVC ()<FSMenuScrollDelegate>
@property (nonatomic,strong) GSMenuScroll *menuScroll;

@end

@implementation GSHomeVC

- (NSString *)tabImageName {
    return @"home_tab_icon_1";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [_titleView setBackgroundColor:[UIColor clearColor]];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 20)];
    [_titleLabel setText:@"精选"];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleView addSubview:_titleLabel];
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(40, 25, 20, 20)];
    _pageControl.backgroundColor=[UIColor clearColor];
    _pageControl.numberOfPages=2;
    _pageControl.currentPage=0;
    _pageControl.transform=CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
    [_titleView addSubview:_pageControl];
    [self.navigationItem setItemWithCustomView:_titleView itemType:center];
//    self.topBtnTouched = NO;
//    self.navigationItem.title = @"精选";

    NSLog(@"selfHeight:%f",self.view.frame.size.height);
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_backScrollV];
    
    _backScrollV.delegate = self;
    _backScrollV.showsHorizontalScrollIndicator = NO;
    _backScrollV.showsVerticalScrollIndicator = NO;
    _backScrollV.backgroundColor = [UIColor clearColor];
    _backScrollV.pagingEnabled = YES;
    _backScrollV.bounces = NO;
    
    self.goodTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    _goodTableView.backgroundView = nil;
    _goodTableView.scrollsToTop = YES;
    _goodTableView.backgroundColor = [UIColor clearColor];
    _goodTableView.showsVerticalScrollIndicator = NO;
    [_backScrollV addSubview:_goodTableView];
    _goodTableView.delegate = self;
    _goodTableView.dataSource = self;
    
    self.focusTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    _focusTableView.backgroundView = nil;
    _focusTableView.scrollsToTop = YES;
    _focusTableView.backgroundColor = [UIColor clearColor];
    _focusTableView.showsVerticalScrollIndicator = NO;
    [_backScrollV addSubview:_focusTableView];
    _focusTableView.delegate = self;
    _focusTableView.dataSource = self;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
    self.backScrollV.frame = self.view.bounds;
    self.backScrollV.contentSize = CGSizeMake(2 * CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.goodTableView.frame = self.view.bounds;
    CGRect rect = self.view.bounds;
    rect.origin.x = CGRectGetWidth(self.view.frame);
    self.focusTableView.frame = rect;
    self.goodTableView.contentOffset = CGPointMake(0, -64);
    self.goodTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.focusTableView.contentOffset = CGPointMake(0, -64);
    self.focusTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.goodTableView]) {
        return 80;
    }
    else
    {
        return 85;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.goodTableView]) {
        return 10;
    }
    else
        return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.goodTableView]) {
        static NSString *cellIdentifier = @"goodCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor getRandomColor];
        cell.textLabel.text = @"tableview1";
        return cell;

    }
    else
    {
        static NSString *cellIdentifier = @"focusCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor getRandomColor];
        cell.textLabel.text = @"tableview2";
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _backScrollV) {
        if (_backScrollV.contentOffset.x==0) {
            [self.menuScroll setSelectedIndex:0 animated:NO calledDelegate:NO];
            [_titleLabel setText:@"精选"];
            _pageControl.currentPage = 0;
        }
        else if(_backScrollV.contentOffset.x==self.view.frame.size.width){
            [self.menuScroll setSelectedIndex:1 animated:NO calledDelegate:NO];
            [_titleLabel setText:@"关注"];
            _pageControl.currentPage = 1;
        }
    }
}


- (void)menuScrollDidSelected:(GSMenuScroll *)menuScroll menuIndex:(NSUInteger)selectIndex {
    if (selectIndex==0) {
        self.topBtnTouched = YES;
        [_backScrollV setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else
    {
        self.topBtnTouched = YES;
        [_backScrollV setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
