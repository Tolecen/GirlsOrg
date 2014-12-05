//
//  GSHomeVC.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSHomeVC.h"
#import "GSMenuScroll.h"

@interface GSHomeVC ()<FSMenuScrollDelegate>
@property (nonatomic,strong) GSMenuScroll *menuScroll;

@end

@implementation GSHomeVC

- (NSString *)tabImageName {
    return @"home_tab_icon_1";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topBtnTouched = NO;
    self.navigationItem.title = @"女人帮";
    self.menuScroll = [[GSMenuScroll alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];
    self.menuScroll.delegate = self;
    [self.view addSubview:self.menuScroll];
    
    NSMutableArray *menus = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        GSMenu *menu = [[GSMenu alloc] init];
        menu.title = (i == 0) ? @"精选" : @"关注";
        [menus addObject:menu];
    }
    
    self.menuScroll.menus = menus.copy;
    [self.menuScroll reloadData];
    
    NSLog(@"selfHeight:%f",self.view.frame.size.height);
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, self.view.frame.size.width, self.view.frame.size.height - 35-50-64)];
    [self.view addSubview:_backScrollV];
    _backScrollV.delegate = self;
    _backScrollV.showsHorizontalScrollIndicator = NO;
    _backScrollV.showsVerticalScrollIndicator = NO;
    _backScrollV.backgroundColor = [UIColor clearColor];
    _backScrollV.contentSize = CGSizeMake(_backScrollV.frame.size.width*2, _backScrollV.frame.size.height);
    _backScrollV.pagingEnabled = YES;
    _backScrollV.bounces = NO;
    
    self.goodTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-35-50-64)];
    _goodTableView.backgroundView = nil;
    _goodTableView.scrollsToTop = YES;
    _goodTableView.backgroundColor = [UIColor clearColor];
//    _goodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _goodTableView.rowHeight = 100;
//    _goodTableView.contentInset = UIEdgeInsetsMake(0, 0, 59, 0);
    _goodTableView.showsVerticalScrollIndicator = NO;
    [_backScrollV addSubview:_goodTableView];
    _goodTableView.delegate = self;
    _goodTableView.dataSource = self;
    
    self.focusTableView = [[UITableView alloc]initWithFrame:CGRectMake( self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-35-50-64)];
    _focusTableView.backgroundView = nil;
    _focusTableView.scrollsToTop = YES;
    _focusTableView.backgroundColor = [UIColor clearColor];
//    _focusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _focusTableView.rowHeight = 100;
    //    _goodTableView.contentInset = UIEdgeInsetsMake(0, 0, 59, 0);
    _focusTableView.showsVerticalScrollIndicator = NO;
    [_backScrollV addSubview:_focusTableView];
    _focusTableView.delegate = self;
    _focusTableView.dataSource = self;
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
        cell.textLabel.text = @"tableview2";
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _backScrollV) {
        if (!self.topBtnTouched) {
            self.menuScroll.indicatorView.frame = CGRectMake((self.view.frame.size.width/2*_backScrollV.contentOffset.x)/self.view.frame.size.width, self.menuScroll.indicatorView.frame.origin.y, self.menuScroll.indicatorView.frame.size.width, self.menuScroll.indicatorView.frame.size.height);
        }
        
        if (_backScrollV.contentOffset.x==0) {
            [self.menuScroll setSelectedIndex:0 animated:NO calledDelegate:NO];
            self.topBtnTouched = NO;
        }
        else if(_backScrollV.contentOffset.x==self.view.frame.size.width){
            [self.menuScroll setSelectedIndex:1 animated:NO calledDelegate:NO];
            self.topBtnTouched = NO;
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
