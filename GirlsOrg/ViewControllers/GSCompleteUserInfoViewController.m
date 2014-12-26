//
//  GSCompleteUserInfoViewController.m
//  GirlsOrg
//
//  Created by Tolecen on 14/12/21.
//  Copyright (c) 2014年 uzero. All rights reserved.
//

#import "GSCompleteUserInfoViewController.h"
#import "DBImageView.h"
#import "InputText.h"
#import "ZHPickView.h"
#import "TTImageHelper.h"
@interface GSCompleteUserInfoViewController ()<UITextFieldDelegate,ZHPickViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    int theType;
}
@property (nonatomic,strong) UIView * contentBGV;
@property (nonatomic,strong) DBImageView * avatarImageV;
@property (nonatomic,strong) UILabel * avatarLabel;
@property (nonatomic, weak)UITextField *nickText;
@property (nonatomic, weak)UILabel *nickTextName;
@property (nonatomic, weak)UITextField *birthText;
@property (nonatomic, weak)UILabel *birthTextName;
@property (nonatomic, weak)UITextField *regionText;
@property (nonatomic, weak)UILabel *regionTextName;
@property (nonatomic, strong)UIButton * birthBtn;
@property (nonatomic, strong)UIButton * regionBtn;
@property (nonatomic, assign) BOOL chang;
@property(nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,strong)UIImage *avatarImg;
@end

@implementation GSCompleteUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    theType = 1;
    self.navigationItem.title = CommonLocalizedStrings(@"completeUserInfo_title");
    
    [self.navigationItem setItemWithCustomView:nil itemType:left];
    
    self.contentBGV = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.contentBGV];
    self.contentBGV.backgroundColor = [UIColor clearColor];
    
    self.avatarImageV = [[DBImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-100)/2, DefaultNaviHeight+40, 100, 100)];
    self.avatarImageV.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    self.avatarImageV.layer.cornerRadius = 50;
    self.avatarImageV.layer.masksToBounds = YES;
    [self.contentBGV addSubview:self.avatarImageV];
    
    self.avatarLabel = [[UILabel alloc] initWithFrame:self.avatarImageV.frame];
    self.avatarLabel.backgroundColor = [UIColor clearColor];
    self.avatarLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.avatarLabel.numberOfLines = 0;
    self.avatarLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentBGV addSubview:self.avatarLabel];
    self.avatarLabel.textColor = [UIColor lightGrayColor];
    self.avatarLabel.text = CommonLocalizedStrings(@"completeUserInfo_addavatar");
    
    UITapGestureRecognizer * tapww = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClicked)];
    [self.avatarImageV addGestureRecognizer:tapww];
    UITapGestureRecognizer * tapww2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClicked)];
    [self.avatarLabel addGestureRecognizer:tapww2];
    
    
    InputText *inputText = [[InputText alloc] init];
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat nickY =DefaultNaviHeight+40+100+30;
    UITextField *emailText = [inputText setupWithIcon:nil textY:nickY centerX:centerX point:nil];
    emailText.keyboardType = UIKeyboardTypeEmailAddress;
    [emailText setReturnKeyType:UIReturnKeyDone];
    emailText.delegate = self;
    self.nickText = emailText;
    [emailText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentBGV addSubview:emailText];
    
    UILabel *emailTextName = [self setupTextName:CommonLocalizedStrings(@"completeUserInfo_nickName") frame:emailText.frame];
    self.nickTextName = emailTextName;
    [self.contentBGV addSubview:emailTextName];
    
    CGFloat verifyCodeY = CGRectGetMaxY(emailText.frame) + 30;
    UITextField *verifyText = [inputText setupWithIcon:nil textY:verifyCodeY centerX:centerX point:nil];
    [verifyText setReturnKeyType:UIReturnKeyDone];
    [verifyText setSecureTextEntry:NO];
    verifyText.delegate = self;
    self.birthText = verifyText;
    [verifyText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentBGV addSubview:verifyText];
    UILabel *verifyTextName = [self setupTextName:CommonLocalizedStrings(@"completeUserInfo_birthday") frame:verifyText.frame];
    self.birthTextName = verifyTextName;
    [self.contentBGV addSubview:verifyTextName];
    
    self.birthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.birthBtn setFrame:self.birthText.frame];
    self.birthBtn.backgroundColor = [UIColor clearColor];
    [self.contentBGV addSubview:self.birthBtn];
    [self.birthBtn addTarget:self action:@selector(birthBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
//    CGFloat passwordY = CGRectGetMaxY(verifyText.frame) + 30;
//    UITextField *passwordText = [inputText setupWithIcon:nil textY:passwordY centerX:centerX point:nil];
//    [passwordText setReturnKeyType:UIReturnKeyDone];
//    [passwordText setSecureTextEntry:NO];
//    passwordText.delegate = self;
//    self.regionText = passwordText;
//    [passwordText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
//    [self.contentBGV addSubview:passwordText];
//    UILabel *passwordTextName = [self setupTextName:CommonLocalizedStrings(@"completeUserInfo_region") frame:passwordText.frame];
//    self.regionTextName = passwordTextName;
//    [self.contentBGV addSubview:passwordTextName];
//    
//    self.regionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.regionBtn setFrame:self.regionText.frame];
//    self.regionBtn.backgroundColor = [UIColor clearColor];
//    [self.contentBGV addSubview:self.regionBtn];
//    [self.regionBtn addTarget:self action:@selector(regionBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    
    [self addBackNavi];
}
-(void)avatarClicked
{
    UIActionSheet *actionSheetTemp = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"相册选择",@"拍照", nil];
    actionSheetTemp.tag = 1;
    [actionSheetTemp showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1) {
        UIImagePickerController * imagePicker;
        if (buttonIndex==1)
        {
            if (imagePicker==nil) {
                imagePicker=[[UIImagePickerController alloc]init];
                imagePicker.delegate=self;
                imagePicker.allowsEditing = YES;
            }
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePicker animated:YES completion:^{
                    
                }];
            }
            else {
                UIAlertView *cameraAlert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的设备不支持相机" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [cameraAlert show];
            }
        }
        else if (buttonIndex==0) {
            if (imagePicker==nil) {
                imagePicker=[[UIImagePickerController alloc]init];
                imagePicker.delegate=self;
                imagePicker.allowsEditing = YES;
            }
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                [imagePicker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:20]
                                                                                  }];
                //                [self presentModalViewController:imagePicker animated:YES];
                [self presentViewController:imagePicker animated:YES completion:^{
                    
                }];
            }
            else {
                UIAlertView *libraryAlert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的设备不支持相册" delegate:self cancelButtonTitle:@"了解" otherButtonTitles:nil];
                [libraryAlert show];
            }
        }
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    self.avatarLabel.hidden = YES;
    UIImage * tempImg = (UIImage *)[info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.avatarImg = [TTImageHelper compressImageDownToPhoneScreenSize:tempImg targetSizeX:200 targetSizeY:200];
    [self.avatarImageV setImage:self.avatarImg];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
}
-(void)birthBtnClicked
{
    [self restoreTextName:self.nickTextName textField:self.nickText];
    [self.nickText resignFirstResponder];
    [_pickview remove];
    theType = 1;
    _pickview=[[ZHPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    [_pickview setPickViewColer:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    _pickview.delegate=self;
    [_pickview show];
    
    if (Inch3_5) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.contentBGV setFrame:CGRectMake(0, -140, CGRectGetWidth(self.view.frame), self.contentBGV.frame.size.height)];
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self.contentBGV setFrame:CGRectMake(0, -40, CGRectGetWidth(self.view.frame), self.contentBGV.frame.size.height)];
        } completion:^(BOOL finished) {
            
        }];
    }

}
-(void)regionBtnClicked
{
    
    [_pickview remove];
    theType = 2;
    _pickview=[[ZHPickView alloc] initPickviewWithPlistName:@"city_china" isHaveNavControler:NO];
    [_pickview setPickViewColer:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    _pickview.delegate=self;
    [_pickview show];
}
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentBGV setFrame:self.view.frame];
    } completion:^(BOOL finished) {
        
    }];
    if (theType==2) {
        self.regionText.text = resultString;
        [self diminishTextName:self.regionTextName];
        [self restoreTextName:self.nickTextName textField:self.nickText];
        [self restoreTextName:self.birthTextName textField:self.birthText];
    }
    else if (theType==1){
        self.birthText.text = resultString;
        [self diminishTextName:self.birthTextName];
        [self restoreTextName:self.nickTextName textField:self.nickText];
        [self restoreTextName:self.regionTextName textField:self.regionText];
        [_pickview remove];
    }
    
}
-(void)toobarCancelBtnHaveClick:(ZHPickView *)pickView
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentBGV setFrame:self.view.frame];
    } completion:^(BOOL finished) {
        
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
    if (textField == self.nickText) {
        [self diminishTextName:self.nickTextName];
        [self restoreTextName:self.birthTextName textField:self.birthText];
        [self restoreTextName:self.regionTextName textField:self.regionText];
        if (Inch3_5) {
            [UIView animateWithDuration:0.3 animations:^{
                [self.contentBGV setFrame:CGRectMake(0, -100, CGRectGetWidth(self.view.frame), self.contentBGV.frame.size.height)];
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self.contentBGV setFrame:CGRectMake(0, -20, CGRectGetWidth(self.view.frame), self.contentBGV.frame.size.height)];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    else if (textField == self.birthText) {
        [self diminishTextName:self.birthTextName];
        [self restoreTextName:self.nickTextName textField:self.nickText];
        [self restoreTextName:self.regionTextName textField:self.regionText];
    }
    else if (textField == self.regionText) {
        [self diminishTextName:self.regionTextName];
        [self restoreTextName:self.nickTextName textField:self.nickText];
        [self restoreTextName:self.birthTextName textField:self.birthText];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentBGV setFrame:self.view.frame];
    } completion:^(BOOL finished) {
        
    }];
    if (textField == self.nickText){
        [self restoreTextName:self.nickTextName textField:self.nickText];
        return [self.nickText resignFirstResponder];
    }
    else if (textField == self.birthText){
        [self restoreTextName:self.birthTextName textField:self.birthText];
        return [self.birthText resignFirstResponder];
    }
    else {
        [self restoreTextName:self.regionTextName textField:self.regionText];
        return [self.regionText resignFirstResponder];
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
    [self restoreTextName:self.nickTextName textField:self.nickText];
    [self restoreTextName:self.birthTextName textField:self.birthText];
    [self restoreTextName:self.regionTextName textField:self.regionText];
    [_pickview remove];
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentBGV setFrame:self.view.frame];
    } completion:^(BOOL finished) {
        
    }];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
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
