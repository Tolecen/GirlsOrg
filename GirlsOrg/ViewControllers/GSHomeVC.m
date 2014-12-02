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

@end

@implementation GSHomeVC

- (NSString *)tabImageName {
    return @"home_tab_icon_1";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    GSMenuScroll *menuScroll = [[GSMenuScroll alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    menuScroll.delegate = self;
    [self.view addSubview:menuScroll];
    
    NSMutableArray *menus = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        GSMenu *menu = [[GSMenu alloc] init];
        menu.title = (i == 0) ? @"关注" : @"订阅";
        [menus addObject:menu];
    }
    
    menuScroll.menus = menus.copy;
    [menuScroll reloadData];
}

- (void)menuScrollDidSelected:(GSMenuScroll *)menuScroll menuIndex:(NSUInteger)selectIndex {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
