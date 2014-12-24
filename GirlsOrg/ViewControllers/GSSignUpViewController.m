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
@interface GSSignUpViewController ()<UITextFieldDelegate>
@property (nonatomic, weak)UITextField *accountText;
@property (nonatomic, weak)UILabel *accountTextName;
@property (nonatomic, weak)UITextField *verifyCodeText;
@property (nonatomic, weak)UILabel *verifyCodeTextName;
@property (nonatomic, weak)UITextField *passwordText;
@property (nonatomic, weak)UILabel *passwordTextName;

@property (nonatomic, strong)UIButton *getVerifyCodeBtn;
@property (nonatomic, strong)UIButton *signUpBtn;
@property (nonatomic, strong)UIButton * protcolBtn;
@property (nonatomic, assign) BOOL chang;
@end

@implementation GSSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = CommonLocalizedStrings(@"signup_page_title");
    [self addBackNavi];
    
    InputText *inputText = [[InputText alloc] init];
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat emailY = 64+30;
    UITextField *emailText = [inputText setupWithIcon:nil textY:emailY centerX:centerX point:nil];
    emailText.keyboardType = UIKeyboardTypeEmailAddress;
    [emailText setReturnKeyType:UIReturnKeyDone];
    emailText.delegate = self;
    self.accountText = emailText;
    [emailText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:emailText];
    
    UILabel *emailTextName = [self setupTextName:CommonLocalizedStrings(@"login_account_pl") frame:emailText.frame];
    self.accountTextName = emailTextName;
    [self.view addSubview:emailTextName];
    
    CGFloat verifyCodeY = CGRectGetMaxY(emailText.frame) + 30;
    UITextField *verifyText = [inputText setupShortWithIcon:nil textY:verifyCodeY centerX:(centerX-(CGRectGetWidth(emailText.frame)-95)/2) point:nil];
    [verifyText setReturnKeyType:UIReturnKeyDone];
    [verifyText setSecureTextEntry:NO];
    verifyText.delegate = self;
    self.verifyCodeText = verifyText;
    [verifyText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:verifyText];
    UILabel *verifyTextName = [self setupTextName:CommonLocalizedStrings(@"login_pwd_pl") frame:verifyText.frame];
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
    [self.signUpBtn setFrame:CGRectMake(self.accountText.frame.origin.x, self.passwordText.frame.origin.y+45, self.accountText.frame.size.width, 35)];
    self.signUpBtn.backgroundColor = RGBCOLOR(250, 89, 172, 1);
    [self.signUpBtn setTitle:CommonLocalizedStrings(@"signup_signup") forState:UIControlStateNormal];
    [self.signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signUpBtn addTarget:self action:@selector(toCompleteUserInfoPage) forControlEvents:UIControlEventTouchUpInside];
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
    
    // Do any additional setup after loading the view.
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

-(void)signUpThisAccount
{
    [self toCompleteUserInfoPage];
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
