//
//  VerPhoneTableViewController.m
//  SuperIntegration
//
//  Created by tmp on 16/4/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "VerPhoneTableViewController.h"

@interface VerPhoneTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLb;
@property (weak, nonatomic) IBOutlet UITextField *FirstPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation VerPhoneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改绑定手机";
    
   
    
    NSString *str = GetObjectUserDefault(@"username");
    NSString *fistStr = [str substringToIndex:3];
    NSString *lastStr = [str substringFromIndex:7];
    
    self.phoneNumLb.text = [NSString stringWithFormat:@"%@****%@",fistStr,lastStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)codeBtnClick:(id)sender {
    
     [self.codeBtn startWithTime:60 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f] countColor:[UIColor lightGrayColor]];
    
    
    [[NetworkService sharedInstance] getChangeTelephoneCodeWithTelephone:self.FirstPhoneTF.text Success:^{
        
        
        [SVProgressHUD showSuccessWithStatus:@"验证码已下发"];
        
    } Failure:^(NSError *error) {
       
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
    }];
    
    
}

- (IBAction)saveClick:(id)sender {
    
    if (STR_IS_NIL(self.FirstPhoneTF.text)) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入新手机号"];
        return;
    }
    
    
    if (STR_IS_NIL(self.codeTF.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if (![Utility checkUserTelNumber:self.FirstPhoneTF.text]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    
    [[NetworkService sharedInstance] getCheckTelephoneCodelWithCode:self.codeTF.text telephone:self.FirstPhoneTF.text Success:^{
        
        
        [[NetworkService sharedInstance] postCheckTelephoneWithTelephone:self.FirstPhoneTF.text Success:^{
            
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            
            SetObjectUserDefault(self.FirstPhoneTF.text, @"username");
            
            UserModel *model = [ModelManager getUserModel];
            model.telephone = self.FirstPhoneTF.text;
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        } Failure:^(NSError *error) {
           
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
        }];
        
        
        
        
    } Failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"errmsg"]];
        
    }];
    
    
    
}

@end