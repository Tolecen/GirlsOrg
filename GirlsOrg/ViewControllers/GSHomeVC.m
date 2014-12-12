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
    firstIn = YES;
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [_titleView setBackgroundColor:[UIColor clearColor]];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 20)];
    [_titleLabel setText:CommonLocalizedStrings(@"homePage_title1")];
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
    _backScrollV.scrollsToTop = NO;
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
    
    self.goodTableViewHelper = [[GSBrowserTableviewHelper alloc] initWithController:self Tableview:self.goodTableView];
    
    _goodTableView.delegate = self.goodTableViewHelper;
    _goodTableView.dataSource = self.goodTableViewHelper;
    self.goodTableViewHelper.tableViewType = TableViewTypeGood;
    
    self.focusTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    _focusTableView.backgroundView = nil;
    _focusTableView.scrollsToTop = NO;
    _focusTableView.backgroundColor = [UIColor clearColor];
    _focusTableView.showsVerticalScrollIndicator = NO;
    [_backScrollV addSubview:_focusTableView];
    
    self.focusTableViewHelper = [[GSBrowserTableviewHelper alloc] initWithController:self Tableview:self.focusTableView];
    
    _focusTableView.delegate = self.focusTableViewHelper;
    _focusTableView.dataSource = self.focusTableViewHelper;
    self.focusTableViewHelper.tableViewType = TableViewTypeFocus;
    
    self.goodTableView.contentOffset = CGPointMake(0, -64);
    self.goodTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.focusTableView.contentOffset = CGPointMake(0, -64);
    self.focusTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
//    NSMutableDictionary * regDict = [GSNetWorkManager commonDict];
//    [regDict setObject:@"login" forKey:@"command"];
//    [regDict setObject:@"15652291050" forKey:@"loginName"];
//    [regDict setObject:@"111111" forKey:@"password"];
//    
//    [GSNetWorkManager requestNOEncryptWithParamaters:regDict];
    [self addBackNavi];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (!firstIn) {
        return;
    }
    firstIn = NO;
    self.backScrollV.frame = self.view.bounds;
    self.backScrollV.contentSize = CGSizeMake(2 * CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.goodTableView.frame = self.view.bounds;
    CGRect rect = self.view.bounds;
    rect.origin.x = CGRectGetWidth(self.view.frame);
    self.focusTableView.frame = rect;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _backScrollV) {
        if (_backScrollV.contentOffset.x==0) {
            [self.menuScroll setSelectedIndex:0 animated:NO calledDelegate:NO];
            [_titleLabel setText:CommonLocalizedStrings(@"homePage_title1")];
            _pageControl.currentPage = 0;
            self.goodTableView.scrollsToTop = YES;
            self.focusTableView.scrollsToTop = NO;
        }
        else if(_backScrollV.contentOffset.x==self.view.frame.size.width){
            [self.menuScroll setSelectedIndex:1 animated:NO calledDelegate:NO];
            [_titleLabel setText:CommonLocalizedStrings(@"homePage_title2")];
            _pageControl.currentPage = 1;
            self.goodTableView.scrollsToTop = NO;
            self.focusTableView.scrollsToTop = YES;
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
