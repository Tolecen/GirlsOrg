//
//  GSSearchVC.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSSearchVC.h"
#import "GSMenuScroll.h"

@interface GSSearchVC ()<FSMenuScrollDelegate>

@end

@implementation GSSearchVC

- (NSString *)tabImageName {
    return @"home_tab_icon_2";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GSMenuScroll *menuScroll = [[GSMenuScroll alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    menuScroll.delegate = self;
    [self.view addSubview:menuScroll];
    
    NSMutableArray *menus = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        GSMenu *menu = [[GSMenu alloc] init];
        switch (i) {
            case 0:
                menu.title = @"话题";
                break;
            case 1:
                menu.title = @"附近";
                break;
            case 2:
                menu.title = @"品牌";
                break;
            case 3:
                menu.title = @"标签";
                break;
            case 4:
                menu.title = @"专题";
                break;
            default:
                break;
        }
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
