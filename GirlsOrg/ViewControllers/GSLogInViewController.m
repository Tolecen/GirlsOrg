//
//  GSLogInViewController.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/13.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSLogInViewController.h"
#import "GSSignUpViewController.h"
#import "InputText.h"
//#import "KVNProgress.h"
#import "GSUserInfo.h"
#import "SFHFKeychainUtils.h"
#import "TOWebViewController.h"
#import "SVProgressHUD.h"
#import "GSAppDelegate.h"
@interface GSLogInViewController ()<UITextFieldDelegate>
@property (nonatomic, weak)UITextField *emailText;
@property (nonatomic, weak)UILabel *emailTextName;
@property (nonatomic, weak)UITextField *passwordText;
@property (nonatomic, weak)UILabel *passwordTextName;
@property (nonatomic, strong)UIButton *loginBtn;
@property (nonatomic, strong)UIButton *regBtn;
@property (nonatomic, strong)UIButton * forgetBtn;
@property (nonatomic, strong)UIView * midView;
@property (nonatomic, strong)UIView * snsBg;
@property (nonatomic, strong)UIButton * protcolBtn;
@property (nonatomic, assign) BOOL chang;
@end

@implementation GSLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = CommonLocalizedStrings(@"login_page_title");
    [self addBackNavi];
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:CGRectMake(0, 0, 50, 44)];
    [bt setBackgroundImage:[UIImage imageNamed:@"login_dismiss"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(dismissLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setItemWithCustomView:bt itemType:left];
    
    InputText *inputText = [[InputText alloc] init];
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat emailY = 64+30;
    UITextField *emailText = [inputText setupWithIcon:nil textY:emailY centerX:centerX point:nil];
    emailText.keyboardType = UIKeyboardTypeNumberPad;
    [emailText setReturnKeyType:UIReturnKeyNext];
    emailText.delegate = self;
    self.emailText = emailText;
    [emailText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:emailText];
    
    UILabel *emailTextName = [self setupTextName:CommonLocalizedStrings(@"login_account_pl") frame:emailText.frame];
    self.emailTextName = emailTextName;
    [self.view addSubview:emailTextName];
    
    CGFloat passwordY = CGRectGetMaxY(emailText.frame) + 30;
    UITextField *passwordText = [inputText setupWithIcon:nil textY:passwordY centerX:centerX point:nil];
    [passwordText setReturnKeyType:UIReturnKeyDone];
    [passwordText setSecureTextEntry:YES];
    passwordText.delegate = self;
    self.passwordText = passwordText;
    [passwordText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passwordText];
    UILabel *passwordTextName = [self setupTextName:CommonLocalizedStrings(@"login_pwd_pl") frame:passwordText.frame];
    self.passwordTextName = passwordTextName;
    [self.view addSubview:passwordTextName];
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setFrame:CGRectMake(self.emailText.frame.origin.x, self.passwordText.frame.origin.y+45, self.emailText.frame.size.width, 35)];
    self.loginBtn.backgroundColor = RGBCOLOR(250, 89, 172, 1);
    [self.loginBtn setTitle:CommonLocalizedStrings(@"login_page_title") forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.loginBtn];
    [self.loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_regBtn setBackgroundColor:[UIColor clearColor]];
    [_regBtn setTitle:CommonLocalizedStrings(@"login_newAccount") forState:UIControlStateNormal];
    _regBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_regBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_regBtn setTitleColor:[UIColor colorWithRed:0 green:0.6 blue:0.933 alpha:1] forState:UIControlStateNormal];
    [_regBtn setFrame:CGRectMake(self.loginBtn.x, self.loginBtn.y+35+10, 100, 20)];
    [self.view addSubview:_regBtn];
    [_regBtn addTarget:self action:@selector(toSignUpPage) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetBtn setBackgroundColor:[UIColor clearColor]];
    [_forgetBtn setTitle:CommonLocalizedStrings(@"login_fogetPwd") forState:UIControlStateNormal];
    _forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_forgetBtn setFrame:CGRectMake(self.emailText.width+self.emailText.x-120, self.loginBtn.y+35+10, 120, 20)];
    [self.view addSubview:_forgetBtn];
    
    self.midView = [[UIView alloc] initWithFrame:CGRectMake(self.emailText.x, _forgetBtn.y+20+30, self.emailText.width, 20)];
    [_midView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_midView];
    
    UIView * lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 10, (_midView.width-120)/2, 1)];
    [lineOne setBackgroundColor:[UIColor lightGrayColor]];
    [_midView addSubview:lineOne];
    
    UILabel * desL = [[UILabel alloc] initWithFrame:CGRectMake((_midView.width-120)/2, 0, 120, 20)];
    [_midView addSubview:desL];
    [desL setBackgroundColor:[UIColor clearColor]];
    [desL setTextColor:[UIColor grayColor]];
    [desL setText:CommonLocalizedStrings(@"login_mid")];
    [desL setFont:[UIFont systemFontOfSize:14]];
    [desL setTextAlignment:NSTextAlignmentCenter];
    
    UIView * lineTwo = [[UIView alloc] initWithFrame:CGRectMake(desL.width+desL.x, 10, (_midView.width-120)/2, 1)];
    [lineTwo setBackgroundColor:[UIColor lightGrayColor]];
    [_midView addSubview:lineTwo];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
//    NSLog(@"hhh:%@",preferredLang);
    BOOL chinese = NO;
    if ([preferredLang isEqualToString:@"zh-Hans"]) {
        chinese = YES;
    }
    else
        chinese = NO;
    
    self.snsBg = [[UIView alloc] initWithFrame:CGRectMake(_midView.x, _midView.y+40, _midView.width, 45)];
    [_snsBg setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_snsBg];
    
    UIButton * sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaBtn setFrame:CGRectMake(chinese?0:(45*2+17.3*2), 0, 45, 45)];
    [sinaBtn setBackgroundImage:[UIImage imageNamed:@"sns_sina"] forState:UIControlStateNormal];
    [_snsBg addSubview:sinaBtn];
    
    UILabel * sinaL = [[UILabel alloc] initWithFrame:CGRectMake(sinaBtn.x, sinaBtn.y+50, 45, 20)];
    sinaL.backgroundColor = [UIColor clearColor];
    sinaL.textAlignment = NSTextAlignmentCenter;
    sinaL.textColor = [UIColor grayColor];
    sinaL.text = CommonLocalizedStrings(@"weibo");
    sinaL.font = [UIFont systemFontOfSize:12];
    [_snsBg addSubview:sinaL];
    
    UIButton * qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setFrame:CGRectMake(chinese?(45+17.3):(45*3+17.3*3), 0, 45, 45)];
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"sns_qq"] forState:UIControlStateNormal];
    [_snsBg addSubview:qqBtn];
    
    UILabel * qqL = [[UILabel alloc] initWithFrame:CGRectMake(qqBtn.x, qqBtn.y+50, 45, 20)];
    qqL.backgroundColor = [UIColor clearColor];
    qqL.textAlignment = NSTextAlignmentCenter;
    qqL.textColor = [UIColor grayColor];
    qqL.text = @"QQ";
    qqL.font = [UIFont systemFontOfSize:12];
    [_snsBg addSubview:qqL];
    
    UIButton * fbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fbBtn setFrame:CGRectMake(chinese?(45*2+17.3*2):0, 0, 45, 45)];
    [fbBtn setBackgroundImage:[UIImage imageNamed:@"sns_facebook"] forState:UIControlStateNormal];
    [_snsBg addSubview:fbBtn];
    
    UILabel * fbL = [[UILabel alloc] initWithFrame:CGRectMake(fbBtn.x-10, fbBtn.y+50, 65, 20)];
    fbL.backgroundColor = [UIColor clearColor];
    fbL.textAlignment = NSTextAlignmentCenter;
    fbL.textColor = [UIColor grayColor];
    fbL.text = @"Facebook";
//    fbL.adjustsFontSizeToFitWidth = YES;
    fbL.font = [UIFont systemFontOfSize:12];
    [_snsBg addSubview:fbL];
    
    
    UIButton * twBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [twBtn setFrame:CGRectMake(chinese?(45*3+17.3*3):(45+17.3), 0, 45, 45)];
    [twBtn setBackgroundImage:[UIImage imageNamed:@"sns_twitter"] forState:UIControlStateNormal];
    [_snsBg addSubview:twBtn];
    
    UILabel * twL = [[UILabel alloc] initWithFrame:CGRectMake(twBtn.x, twBtn.y+50, 45, 20)];
    twL.backgroundColor = [UIColor clearColor];
    twL.textAlignment = NSTextAlignmentCenter;
    twL.textColor = [UIColor grayColor];
    twL.text = @"Twitter";
    twL.font = [UIFont systemFontOfSize:12];
    [_snsBg addSubview:twL];
    
    self.protcolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_protcolBtn setFrame:CGRectMake((self.view.width-200)/2, self.view.height-40, 200, 40)];
    [_protcolBtn setBackgroundColor:[UIColor clearColor]];
    [_protcolBtn setTitle:CommonLocalizedStrings(@"login_readAgreement") forState:UIControlStateNormal];
    [_protcolBtn setTitleColor:[UIColor colorWithRed:0 green:0.6 blue:0.933 alpha:1] forState:UIControlStateNormal];
    _protcolBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_protcolBtn];
    [_protcolBtn addTarget:self action:@selector(toProtocolPage) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (!firstIn) {
        return;
    }
    firstIn = NO;
    [self.loginBtn setFrame:CGRectMake(self.emailText.frame.origin.x, self.passwordText.frame.origin.y+45, self.emailText.frame.size.width, 35)];
    [_regBtn setFrame:CGRectMake(self.loginBtn.x, self.loginBtn.y+35+10, 100, 20)];
    [_forgetBtn setFrame:CGRectMake(self.emailText.width+self.emailText.x-120, self.loginBtn.y+35+10, 120, 20)];
    [self.midView setFrame:CGRectMake(self.emailText.x, _forgetBtn.y+20+30, self.emailText.width, 20)];
    [self.snsBg setFrame:CGRectMake(_midView.x, _midView.y+40, _midView.width, 45)];
    [_protcolBtn setFrame:CGRectMake((self.view.width-200)/2, self.view.height-40, 200, 40)];
}
-(void)regiterTest
{
    NSMutableDictionary* mDict = [GSNetWorkManager commonDict];
    [mDict setObject:@"member" forKey:@"service"];
    [mDict setObject:@"signin" forKey:@"method"];
    [mDict setObject:@"15652291050" forKey:@"username"];
    [mDict setObject:@"111111" forKey:@"password"];
    [GSNetWorkManager requestWithParamaters:mDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)loginBtnClicked
{
    if (!self.emailText||self.emailText.text.length==0) {
        [SVProgressHUD showErrorWithStatus:CommonLocalizedStrings(@"signup_noPhoneNum")];
        return;
    }
    if ((self.passwordText.text.length>0&&self.passwordText.text.length<6)||(self.passwordText.text.length>0&&self.passwordText.text.length>16)) {
        [SVProgressHUD showErrorWithStatus:CommonLocalizedStrings(@"signup_pwdFormatWrong")];
        return;
    }
    else if (!self.passwordText.text||self.passwordText.text.length==0){
        [SVProgressHUD showErrorWithStatus:CommonLocalizedStrings(@"signup_noPWD")];
        return;
    }
    
    [self.emailText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    [SVProgressHUD showWithStatus:CommonLocalizedStrings(@"loggingin")];
    NSMutableDictionary * dict = [GSNetWorkManager commonDict];
    [dict setObject:@"member" forKey:@"service"];
    [dict setObject:@"login" forKey:@"method"];
    [dict setObject:self.emailText.text forKey:@"username"];
    [dict setObject:self.passwordText.text forKey:@"password"];
    [GSNetWorkManager requestWithParamaters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        GSUserInfo * uInfo = [[GSUserInfo alloc] initWithUserInfo:responseObject[@"data"]];
        [GSDBManager saveUserInfoWithUserInfo:uInfo];
        [SFHFKeychainUtils storeUsername:SFHAccount andPassword:[[responseObject objectForKey:@"data"] objectForKey:@"username"] forServiceName:SFHServiceName updateExisting:YES error:nil];
        [SFHFKeychainUtils storeUsername:SFHToken andPassword:[[responseObject objectForKey:@"data"] objectForKey:@"token"] forServiceName:SFHServiceName updateExisting:YES error:nil];
        [GSSystem sharedSystem].token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
        [self dismissLogin];
         [[GSAppDelegate shareInstance] login:nil selector:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString * errorCode = [NSString stringWithFormat:@"%ld",(long)[error code]];
        [SVProgressHUD showErrorWithStatus:CommonLocalizedStrings(errorCode)];
    }];

    
}

-(void)toSignUpPage
{
    GSSignUpViewController * signupV = [[GSSignUpViewController alloc] init];
    [self.navigationController pushViewController:signupV animated:YES];
}
- (UILabel *)setupTextName:(NSString *)textName frame:(CGRect)frame
{
    UILabel *textNameLabel = [[UILabel alloc] init];
    textNameLabel.text = textName;
    textNameLabel.font = [UIFont systemFontOfSize:16];
    textNameLabel.textColor = [UIColor grayColor];
    textNameLabel.frame = frame;
    return textNameLabel;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.emailText) {
        [self diminishTextName:self.emailTextName];
        [self restoreTextName:self.passwordTextName textField:self.passwordText];
    } else if (textField == self.passwordText) {
        [self diminishTextName:self.passwordTextName];
        [self restoreTextName:self.emailTextName textField:self.emailText];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailText){
        return [self.passwordText becomeFirstResponder];
    } else {
        [self restoreTextName:self.passwordTextName textField:self.passwordText];
        return [self.passwordText resignFirstResponder];
    }
}
- (void)diminishTextName:(UILabel *)label
{
    [UIView animateWithDuration:0.5 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, -16);
        label.font = [UIFont systemFontOfSize:9];
    }];
}
- (void)restoreTextName:(UILabel *)label textField:(UITextField *)textFieled
{
    [self textFieldTextChange:textFieled];
    if (self.chang) {
        [UIView animateWithDuration:0.5 animations:^{
            label.transform = CGAffineTransformIdentity;
            label.font = [UIFont systemFontOfSize:16];
        }];
    }
}
- (void)textFieldTextChange:(UITextField *)textField
{
    if (textField.text.length != 0) {
        self.chang = NO;
    } else {
        self.chang = YES;
    }
}
- (void)textFieldDidChange
{
    if (self.emailText.text.length != 0 && self.passwordText.text.length != 0) {
        self.loginBtn.enabled = YES;
    } else {
        self.loginBtn.enabled = NO;
    }
}
#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self restoreTextName:self.emailTextName textField:self.emailText];
    [self restoreTextName:self.passwordTextName textField:self.passwordText];
}

-(void)dismissLogin
{
    [self.emailText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)toProtocolPage
{
    NSURL * url = [NSURL URLWithString:UserAgreementUrlStr];
    
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    
    [self.navigationController pushViewController:webViewController animated:YES];
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
