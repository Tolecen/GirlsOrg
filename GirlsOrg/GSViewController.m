//
//  GSViewController.m
//  GirlsOrg
//
//  Created by LiuXiaoyu on 11/11/14.
//  Copyright (c) 2014 uzero. All rights reserved.
//

#import "GSViewController.h"
#import "UIViewController+GSTarBarController.h"

@interface GSViewController ()

@end

@implementation GSViewController

- (NSString *)tabImageName {
    return @"home_tab_icon_2";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%255 / 255.f) green:(arc4random()%255 / 255.f) blue:(arc4random()%255 / 255.f) alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
