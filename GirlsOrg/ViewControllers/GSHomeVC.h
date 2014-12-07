//
//  GSHomeVC.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSBaseViewController.h"
#import "MJRefresh.h"
#import "GSBrowserTableviewHelper.h"
@interface GSHomeVC : GSBaseViewController<UIScrollViewDelegate>
@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong) UIScrollView * backScrollV;
@property (nonatomic, strong) UITableView * goodTableView;
@property (nonatomic, strong) UITableView * focusTableView;
@property (nonatomic, assign) BOOL topBtnTouched;
@property (nonatomic, strong) GSBrowserTableviewHelper * goodTableViewHelper;
@property (nonatomic, strong) GSBrowserTableviewHelper * focusTableViewHelper;
@end
