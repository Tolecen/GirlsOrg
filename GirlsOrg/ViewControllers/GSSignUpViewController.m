//
//  GSSignUpViewController.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/21.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSSignUpViewController.h"
#import "GSCompleteUserInfoViewController.h"
#import "InputText.h"
#import "IdentifyingString.h"
#import "KVNProgress.h"
#import "GSAreaCode.h"
#import "SMS_SDK/SMS_SDK.h"
#import "SMS_SDK/CountryAndAreaCode.h"
#import "SectionsViewController.h"
#import "SFHFKeychainUtils.h"
#import "TOWebViewController.h"
#define NeedVerifyCode NO

@interface GSSignUpViewController ()<UITextFieldDelegate,SecondViewControllerDelegate>
{
    int remainingTime;
}
@property (nonatomic, weak)UITextField *accountText;
@property (nonatomic, weak)UILabel *accountTextName;
@property (nonatomic, weak)UITextField *verifyCodeText;
@property (nonatomic, weak)UILabel *verifyCodeTextName;
@property (nonatomic, weak)UITextField *passwordText;
@property (nonatomic, weak)UILabel *passwordTextName;
@property (nonatomic, strong)UIButton *countryBtn;
@property (nonatomic, strong)UIButton *getVerifyCodeBtn;
@property (nonatomic, strong)UIButton *signUpBtn;
@property (nonatomic, strong)UIButton * protcolBtn;
@property (nonatomic, assign) BOOL chang;
@property (nonatomic, strong)NSString * countryCode;
@property (nonatomic, strong)NSString * countryName;
@property (nonatomic, strong)NSMutableArray * areaArray;
@property (nonatomic,strong)NSTimer * checkT;
@end

@implementation GSSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = CommonLocalizedStrings(@"signup_page_title");
    [self addBackNavi];
    
    self.areaArray = [NSMutableArray array];
    remainingTime = 60;
    
    InputText *inputText = [[InputText alloc] init];
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat emailY = 64+30;
    UITextField *emailText = [inputText setupWithIcon:nil textY:emailY centerX:centerX point:nil];
    [emailText setFrame:CGRectMake(emailText.x+70, emailText.y, emailText.width-70, emailText.height)];
    emailText.keyboardType = UIKeyboardTypeNumberPad;
    [emailText setReturnKeyType:UIReturnKeyDone];
    emailText.delegate = self;
    self.accountText = emailText;
    [emailText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:emailText];
    
    self.countryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.countryBtn setFrame:CGRectMake(emailText.x-70, emailText.y-5, 65, 30)];
    [self.countryBtn setBackgroundColor:[UIColor clearColor]];
    self.countryBtn.layer.cornerRadius = 4;
    self.countryBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.countryBtn.layer.borderWidth = 1;
    self.countryBtn.layer.masksToBounds = YES;
    [self.countryBtn setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:UIControlStateNormal];
    self.countryBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.countryBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.countryBtn setTitle:@"▼+86" forState:UIControlStateNormal];
    [self.view addSubview:self.countryBtn];
    [self.countryBtn addTarget:self action:@selector(toSelectCountryPage) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *emailTextName = [self setupTextName:CommonLocalizedStrings(@"login_account_pl") frame:emailText.frame];
    self.accountTextName = emailTextName;
    [self.view addSubview:emailTextName];
    
    CGFloat verifyCodeY = CGRectGetMaxY(emailText.frame) + 30;
    UITextField *verifyText = [inputText setupShortWithIcon:nil textY:verifyCodeY centerX:(centerX-(232-95)/2) point:nil];
    [verifyText setReturnKeyType:UIReturnKeyDone];
    verifyText.keyboardType = UIKeyboardTypeNumberPad;
    [verifyText setSecureTextEntry:NO];
    verifyText.delegate = self;
    self.verifyCodeText = verifyText;
    [verifyText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:verifyText];
    UILabel *verifyTextName = [self setupTextName:CommonLocalizedStrings(@"signup_fillVerifyCode") frame:verifyText.frame];
    self.verifyCodeTextName = verifyTextName;
    [self.view addSubview:verifyTextName];
    
    self.getVerifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getVerifyCodeBtn setFrame:CGRectMake(verifyText.x+CGRectGetWidth(verifyText.frame)+15, verifyText.y-5, 120, 30)];
    self.getVerifyCodeBtn.backgroundColor = RGBCOLOR(250, 89, 172, 0.8);
    [self.getVerifyCodeBtn setTitle:CommonLocalizedStrings(@"signup_getVerifyCode") forState:UIControlStateNormal];
    [self.getVerifyCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getVerifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.getVerifyCodeBtn.layer.cornerRadius = 5;
    self.getVerifyCodeBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.getVerifyCodeBtn];
    [self.getVerifyCodeBtn addTarget:self action:@selector(sendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat passwordY = CGRectGetMaxY(verifyText.frame) + 30;
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
    
    self.signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.signUpBtn setFrame:CGRectMake(self.passwordText.frame.origin.x, self.passwordText.frame.origin.y+45, self.passwordText.frame.size.width, 35)];
    self.signUpBtn.backgroundColor = RGBCOLOR(250, 89, 172, 1);
    [self.signUpBtn setTitle:CommonLocalizedStrings(@"signup_signup") forState:UIControlStateNormal];
    [self.signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signUpBtn addTarget:self action:@selector(signUpThisAccount) forControlEvents:UIControlEventTouchUpInside];
    self.signUpBtn.layer.cornerRadius = 5;
    self.signUpBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.signUpBtn];
    
    self.protcolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_protcolBtn setFrame:CGRectMake((self.view.width-200)/2, self.view.height-40, 200, 40)];
    [_protcolBtn setBackgroundColor:[UIColor clearColor]];
    [_protcolBtn setTitle:CommonLocalizedStrings(@"login_readAgreement") forState:UIControlStateNormal];
    [_protcolBtn setTitleColor:[UIColor colorWithRed:0 green:0.6 blue:0.933 alpha:1] forState:UIControlStateNormal];
    _protcolBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_protcolBtn];
    [_protcolBtn addTarget:self action:@selector(toProtocolPage) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary * areaDict = [GSAreaCode setTheLocalAreaCode];
    self.countryCode = areaDict[@"countryCode"];
    self.countryName = areaDict[@"countryName"];
    
    [SMS_SDK enableAppContactFriends:NO];
    [SMS_SDK getZone:^(enum SMS_ResponseState state, NSArray *array) {
        if (1==state)
        {
            NSLog(@"block 获取区号成功");
            //区号数据
            _areaArray=[NSMutableArray arrayWithArray:array];
        }
        else if (0==state)
        {
            NSLog(@"block 获取区号失败");
        }
        
    }];
    
    [self.countryBtn setTitle:[NSString stringWithFormat:@"▼+%@",self.countryCode] forState:UIControlStateNormal];
    
//    [self.accountText becomeFirstResponder];
    // Do any additional setup after loading the view.
}
-(void)toSelectCountryPage
{
    SectionsViewController* country2=[[SectionsViewController alloc] init];
    country2.delegate=self;
    [country2 setAreaArray:_areaArray];
    [self.navigationController pushViewController:country2 animated:YES];
}
-(void)setSecondData:(CountryAndAreaCode *)data
{
    self.countryCode = data.areaCode;
    self.countryName = data.countryName;
    [self.countryBtn setTitle:[NSString stringWithFormat:@"▼+%@",data.areaCode] forState:UIControlStateNormal];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    if (!firstIn) {
//        return;
//    }
//    firstIn = NO;
//    [self.loginBtn setFrame:CGRectMake(self.emailText.frame.origin.x, self.passwordText.frame.origin.y+45, self.emailText.frame.size.width, 35)];
//    [_regBtn setFrame:CGRectMake(self.loginBtn.x, self.loginBtn.y+35+10, 100, 20)];
//    [_forgetBtn setFrame:CGRectMake(self.emailText.width+self.emailText.x-120, self.loginBtn.y+35+10, 120, 20)];
//    [self.midView setFrame:CGRectMake(self.emailText.x, _forgetBtn.y+20+30, self.emailText.width, 20)];
//    [self.snsBg setFrame:CGRectMake(_midView.x, _midView.y+40, _midView.width, 45)];
//    [_protcolBtn setFrame:CGRectMake((self.view.width-200)/2, self.view.height-40, 200, 40)];
}

-(void)sendVerifyCode
{
    if (self.accountText.text.length>0) {
        if (![self checkUniversalPhoneNum]) {
            [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_wrongPhoneNum")];
            return;
        }
    }
    else if(!self.accountText.text||self.accountText.text.length==0)
    {
        [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_noPhoneNum")];
        return;
    }
    [SMS_SDK getVerifyCodeByPhoneNumber:self.accountText.text AndZone:self.countryCode result:^(enum SMS_GetVerifyCodeResponseState state) {
        if (1==state) {
            NSLog(@"block 获取验证码成功");
            remainingTime = 60;
            self.getVerifyCodeBtn.backgroundColor = [UIColor lightGrayColor];
            [self.getVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%@(60s)",CommonLocalizedStrings(@"signup_resend")] forState:UIControlStateNormal];
            self.checkT = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateWaitingTimer) userInfo:nil repeats:YES];
            
        }
        else if(0==state)
        {
            NSLog(@"block 获取验证码失败");
            [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"codesenderrormsg")];
            
        }
        else if (SMS_ResponseStateMaxVerifyCode==state)
        {
            [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"maxcodemsg")];
        }
        else if(SMS_ResponseStateGetVerifyCodeTooOften==state)
        {
            [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"codetoooftenmsg")];
        }
    }];
}

-(void)updateWaitingTimer
{
    remainingTime--;
    [self.getVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%@(%ds)",CommonLocalizedStrings(@"signup_resend"),remainingTime] forState:UIControlStateNormal];
    [self.getVerifyCodeBtn setEnabled:NO];
    if (remainingTime<=0) {
        [self.getVerifyCodeBtn setTitle:CommonLocalizedStrings(@"signup_getVerifyCode") forState:UIControlStateNormal];
        [self.getVerifyCodeBtn setEnabled:YES];
        self.getVerifyCodeBtn.backgroundColor = RGBCOLOR(250, 89, 172, 0.8);
        if (self.checkT != nil) {
            if( [self.checkT isValid])
            {
                [self.checkT invalidate];
            }
            self.checkT = nil;
        }
    }
}

-(BOOL)authVeryCode
{
    __block BOOL resultB = NO;
    [KVNProgress showWithStatus:CommonLocalizedStrings(@"authing")];
    [SMS_SDK commitVerifyCode:self.verifyCodeText.text result:^(enum SMS_ResponseState state) {
        if (1==state) {
            NSLog(@"block 验证成功");
//            NSString* str=[NSString stringWithFormat:NSLocalizedString(@"verifycoderightmsg", nil)];
//            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"verifycoderighttitle", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
//            [alert show];
//            _alert3=alert;
            [KVNProgress dismiss];
            resultB = YES;
        }
        else if(0==state)
        {
            NSLog(@"block 验证失败");
            [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"verifycodeerrormsg")];
//            NSString* str=[NSString stringWithFormat:NSLocalizedString(@"verifycodeerrormsg", nil)];
//            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"verifycodeerrortitle", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil)  otherButtonTitles:nil, nil];
//            [alert show];
            resultB = NO;
        }
    }];
    return resultB;
}

-(void)signUpThisAccount
{
//    [self toCompleteUserInfoPage];
//    return;
 
    if (self.accountText.text.length>0) {
        if (![self checkUniversalPhoneNum]) {
            [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_wrongPhoneNum")];
            return;
        }
    }
    else if(!self.accountText.text||self.accountText.text.length==0)
    {
        [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_noPhoneNum")];
        return;
    }
    

    
    if ((self.passwordText.text.length>0&&self.passwordText.text.length<6)||(self.passwordText.text.length>0&&self.passwordText.text.length>16)) {
        [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_pwdFormatWrong")];
        return;
    }
    else if (!self.passwordText.text||self.passwordText.text.length==0){
        [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_noPWD")];
        return;
    }
    
    if (NeedVerifyCode) {
        if (self.verifyCodeText.text.length>0&&self.verifyCodeText.text.length!=4) {
            //            if (![IdentifyingString validateMobile:textField.text]) {
            [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_vNumFormatWrong")];
            return;
            //            }
        }
        else if (!self.verifyCodeText.text||self.verifyCodeText.text.length==0)
        {
            [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_noVNum")];
            return;
        }
        else if (self.verifyCodeText.text.length==4){
            if ([self authVeryCode]) {
                [self regThisAccount];
            }
        }
    }
    else
    {
        [self regThisAccount];
    }
    

}

-(void)regThisAccount
{
    [KVNProgress showWithStatus:CommonLocalizedStrings(@"signingup")];
    NSMutableDictionary * dict = [GSNetWorkManager commonDict];
    [dict setObject:@"member" forKey:@"service"];
    [dict setObject:@"signup" forKey:@"method"];
    [dict setObject:self.accountText.text forKey:@"username"];
    [dict setObject:self.passwordText.text forKey:@"password"];
    [GSNetWorkManager requestWithEncryptParamaters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [KVNProgress dismiss];
        GSUserInfo * uInfo = [[GSUserInfo alloc] initWithUserInfo:responseObject[@"data"]];
        [GSDBManager saveUserInfoWithUserInfo:uInfo];
        [SFHFKeychainUtils storeUsername:SFHAccount andPassword:[[responseObject objectForKey:@"data"] objectForKey:@"username"] forServiceName:SFHServiceName updateExisting:YES error:nil];
        [SFHFKeychainUtils storeUsername:SFHToken andPassword:[[responseObject objectForKey:@"data"] objectForKey:@"token"] forServiceName:SFHServiceName updateExisting:YES error:nil];
        [GSSystem sharedSystem].token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
        [GSSystem sharedSystem].userid = [[responseObject objectForKey:@"data"] objectForKey:@"id"];
        [GSSystem sharedSystem].username = [[responseObject objectForKey:@"data"] objectForKey:@"username"];
        [self toCompleteUserInfoPage];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString * errorCode = [NSString stringWithFormat:@"%ld",(long)[error code]];
        [KVNProgress showErrorWithStatus:CommonLocalizedStrings(errorCode)];
    }];
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
    if (textField == self.accountText) {
        [self diminishTextName:self.accountTextName];
        [self restoreTextName:self.passwordTextName textField:self.passwordText];
        [self restoreTextName:self.verifyCodeTextName textField:self.verifyCodeText];
    }
    else if (textField == self.verifyCodeText) {
        [self diminishTextName:self.verifyCodeTextName];
        [self restoreTextName:self.accountTextName textField:self.accountText];
        [self restoreTextName:self.passwordTextName textField:self.passwordText];
    }
    else if (textField == self.passwordText) {
        [self diminishTextName:self.passwordTextName];
        [self restoreTextName:self.accountTextName textField:self.accountText];
        [self restoreTextName:self.verifyCodeTextName textField:self.verifyCodeText];
    }
    return YES;
}
-(BOOL)checkUniversalPhoneNum
{
    int compareResult = 0;
    for (int i=0; i<_areaArray.count; i++) {
        NSDictionary* dict1=[_areaArray objectAtIndex:i];
        NSString* code1=[dict1 valueForKey:@"zone"];
        NSLog(@"areacode:%@",code1);
        if ([code1 isEqualToString:self.countryCode]) {
            compareResult=1;
            NSString* rule1=[dict1 valueForKey:@"rule"];
            NSLog(@"rule:%@",rule1);
            NSPredicate* pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule1];
            BOOL isMatch=[pred evaluateWithObject:self.accountText.text];
            if (!isMatch) {
                //手机号码不正确
                
                return NO;
            }
            break;
        }
    }
    return YES;

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.accountText) {
        if (textField.text.length>0) {
            if (![self checkUniversalPhoneNum]) {
                [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_wrongPhoneNum")];
            }
            else
            {
                [self checkUsernameIfExsit];
            }
        }
    }
    else if (textField == self.verifyCodeText) {
        if (textField.text.length>0&&textField.text.length!=4) {
//            if (![IdentifyingString validateMobile:textField.text]) {
                [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_vNumFormatWrong")];
//            }
        }
        else if (textField.text.length==4){
            [self authVeryCode];
        }
    }
    else if (textField == self.passwordText) {
        if ((textField.text.length>0&&textField.text.length<6)||(textField.text.length>0&&textField.text.length>16)) {
            [KVNProgress showErrorWithStatus:CommonLocalizedStrings(@"signup_pwdFormatWrong")];
        }
    }
}
-(void)checkUsernameIfExsit
{
    NSMutableDictionary * dict = [GSNetWorkManager commonDict];
    [dict setObject:@"member" forKey:@"service"];
    [dict setObject:@"check_username" forKey:@"method"];
    [dict setObject:self.accountText.text forKey:@"username"];
    [GSNetWorkManager requestWithEncryptParamaters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString * errorCode = [NSString stringWithFormat:@"%ld",(long)[error code]];
        [KVNProgress showErrorWithStatus:CommonLocalizedStrings(errorCode)];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.accountText){
        [self restoreTextName:self.accountTextName textField:self.accountText];
        return [self.accountText resignFirstResponder];
    }
    else if (textField == self.verifyCodeText){
        [self restoreTextName:self.verifyCodeTextName textField:self.verifyCodeText];
        return [self.verifyCodeText resignFirstResponder];
    }
    else {
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
//    if (self.emailText.text.length != 0 && self.passwordText.text.length != 0) {
//        self.loginBtn.enabled = YES;
//    } else {
//        self.loginBtn.enabled = NO;
//    }
}
#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self restoreTextName:self.accountTextName textField:self.accountText];
    [self restoreTextName:self.verifyCodeTextName textField:self.verifyCodeText];
    [self restoreTextName:self.passwordTextName textField:self.passwordText];
}

-(void)toCompleteUserInfoPage
{
    GSCompleteUserInfoViewController * completeV = [[GSCompleteUserInfoViewController alloc] init];
    [self.navigationController pushViewController:completeV animated:YES];
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
