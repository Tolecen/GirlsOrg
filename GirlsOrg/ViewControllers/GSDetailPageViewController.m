//
//  GSDetailPageViewController.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/8.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSDetailPageViewController.h"

@interface GSDetailPageViewController ()

@end

@implementation GSDetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = CommonLocalizedStrings(@"detailPage_title");
//    [[UINavigationBar appearance] setBarTintColor:RGBCOLOR(250, 89, 172, 1)];
    // Do any additional setup after loading the view.
    
    [self addBackNavi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
