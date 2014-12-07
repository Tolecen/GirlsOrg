//
//  GSBrowserTableviewHelper.h
//  GirlsOrg
//
//  Created by Tolecen on 14/12/7.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"
typedef enum {
    TableViewTypeGood = 0,
    TableViewTypeFocus
} TableViewType;
@interface GSBrowserTableviewHelper : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableV;
@property (nonatomic,weak)UIViewController * theController;
@property (nonatomic,assign)TableViewType tableViewType;

-(id)initWithController:(UIViewController *)thexController Tableview:(UITableView *)theTable;
@end
