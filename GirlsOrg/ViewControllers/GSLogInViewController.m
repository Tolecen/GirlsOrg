//
//  GSLogInViewController.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/13.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSLogInViewController.h"

@interface GSLogInViewController ()

@end

@implementation GSLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = CommonLocalizedStrings(@"login_page_title");
    [self addBackNavi];
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:CGRectMake(0, 0, 89, 44)];
    [bt setBackgroundImage:[UIImage imageNamed:@"login_dismiss"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(dismissLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setItemWithCustomView:bt itemType:left];
    // Do any additional setup after loading the view.
}
-(void)dismissLogin
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
