//
//  GSProfileVC.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSProfileVC.h"

@interface GSProfileVC ()

@end

@implementation GSProfileVC

- (NSString *)tabImageName {
    return @"home_tab_icon_3";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = CommonLocalizedStrings(@"personalCenter_title");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
