//
//  GSHomeVC.h
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSBaseViewController.h"

@interface GSHomeVC : GSBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIScrollView * backScrollV;
@property (nonatomic, strong) UITableView * goodTableView;
@property (nonatomic, strong) UITableView * focusTableView;
@end
