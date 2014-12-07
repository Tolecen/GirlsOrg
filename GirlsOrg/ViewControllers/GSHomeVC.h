//
//  GSHomeVC.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSBaseViewController.h"

@interface GSHomeVC : GSBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong) UIScrollView * backScrollV;
@property (nonatomic, strong) UITableView * goodTableView;
@property (nonatomic, strong) UITableView * focusTableView;
@property (nonatomic, assign) BOOL topBtnTouched;
@end
