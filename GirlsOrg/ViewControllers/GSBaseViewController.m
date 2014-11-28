//
//  GSBaseViewController.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSBaseViewController.h"

@interface GSBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation GSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:RGBCOLOR(255, 128, 255, 1)];
    self.view.backgroundColor = RGBCOLOR(243, 243, 243, 1);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count > 1 && ([UIDevice currentDevice].systemName.floatValue >= 7.0)) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
