//
//  GSBaseViewController.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/28/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSBaseViewController.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "GSTabBarController.h"

@interface GSBaseViewController ()<DBCameraViewControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation GSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    firstIn = YES;
    if (IOS7) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:20]
                                                                      }];
    self.view.backgroundColor = RGBCOLOR(243, 243, 243, 1);
//    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)openCamera {
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    DBCameraContainerViewController *cameraContainer = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [cameraContainer setFullScreenMode];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraContainer];
    [nav setNavigationBarHidden:YES];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
//    DetailViewController *detail = [[DetailViewController alloc] init];
//    [detail setDetailImage:image];
//    [self.navigationController pushViewController:detail animated:NO];
    [cameraViewController restoreFullScreenMode];
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissCamera:(id)cameraViewController {
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//    if (IOS7){
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//    }

    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    if (!self.firstTimeIn) {
//        self.firstTimeIn = YES;
//    }
//    else
//    {
//        return;
//    }
//    if (self.view.frame.size.width==0) {
//        return;
//    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (IOS7){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count > 1 && IOS7) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        GSTabBarController * tabV = (GSTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        if (!tabV->tabBar.hidden) {
            [tabV hideTabBar:GSShowHideFromRight animated:YES];
        }
        
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
