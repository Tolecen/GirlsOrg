//
//  GSCompleteUserInfoViewController.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/21.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSCompleteUserInfoViewController.h"

@interface GSCompleteUserInfoViewController ()

@end

@implementation GSCompleteUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = CommonLocalizedStrings(@"completeUserInfo_title");
    [self addBackNavi];
    // Do any additional setup after loading the view.
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
