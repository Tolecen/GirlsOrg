//
//  GSSettingViewController.m
//  GirlsOrg
//
//  Created by TaoXinle on 16/4/14.
//  Copyright © 2016年 uzero. All rights reserved.
//

#import "GSSettingViewController.h"
#import "FWAlertHelper.h"
#import "SFHFKeychainUtils.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"
@interface GSSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float cacheSize;
}
@property (nonatomic,strong) UITableView * profileTableView;
@property (nonatomic,strong)NSArray * titleArray;
@end

@implementation GSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    cacheSize = 0.f;
    
    self.titleArray = @[@"关于我们",@"给个好评",@"清除缓存",@"退出登录"];
    
    self.profileTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, DefaultNaviHeight, Screen_Width, Screen_Width-DefaultNaviHeight) style:UITableViewStyleGrouped];
    //    _profileTableView.backgroundView = nil;
    _profileTableView.scrollsToTop = YES;
    _profileTableView.backgroundColor = self.view.backgroundColor;
    _profileTableView.showsVerticalScrollIndicator = NO;
    _profileTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_profileTableView];
    _profileTableView.dataSource = self;
    _profileTableView.delegate = self;
    // Do any additional setup after loading the view.
    
    [self addBackNavi];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self calCacheSize];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"settingcellw";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    if (indexPath.section==0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.titleArray[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = RGBCOLOR(100, 100, 100, 1);
    }
    else if (indexPath.section==1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存 (约%.2fM)",(double)cacheSize/1024/1024];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = RGBCOLOR(100, 100, 100, 1);
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = self.titleArray[3];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        [FWAlertHelper alertWithTitle:@"退出登录"
                              message:@"确认退出登录吗?"
                           completion:^(NSInteger buttonIndex, NSString *title) {
                               if ([title isEqualToString:@"确定"]) {
                                   [SFHFKeychainUtils deleteItemForUsername:SFHAccount andServiceName:SFHServiceName error:nil];
                                   [SFHFKeychainUtils deleteItemForUsername:SFHToken andServiceName:SFHServiceName error:nil];
                                   [self.navigationController popToRootViewControllerAnimated:NO];
                                   
                               }
                           } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
    else if(indexPath.section==1){
        [SVProgressHUD showWithStatus:@"清理中..."];
        //        [[SDImageCache sharedImageCache] setMaxCacheSize:1];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] cleanDiskManualWithCompletionBlock:^{
            [SVProgressHUD showSuccessWithStatus:@"清理完成"];
            [self calCacheSize];
        }];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        default:
            return 1;
            break;
    }
}

-(void)calCacheSize
{
    cacheSize = [[SDImageCache sharedImageCache] getSize];
    [self.profileTableView reloadData];
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
