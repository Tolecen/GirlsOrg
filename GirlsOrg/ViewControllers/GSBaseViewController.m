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
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = RGBCOLOR(243, 243, 243, 1);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count > 1 && IOS7) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)acceptNavigationHeight {
    if (IOS7) {
        return [UIApplication sharedApplication].statusBarFrame.size.height + 44;
    } else {
        return 44;
    }
}

@end
